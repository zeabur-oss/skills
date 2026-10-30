{
  description = "zeabur-oss agent skills: the dev shell for their checks";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # unstable Nixpkgs
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      # Another repository lints its text with the zeabur-writing style by adding both to its
      # dev shell, pinned by its flake.lock:
      #   inputs.oss-skills.url = "github:zeabur-oss/skills";
      #   packages = [ pkgs.vale oss-skills.packages.${system}.mdx2vast ];
      packages = forAll (pkgs: {
        mdx2vast = pkgs.callPackage ./nix/mdx2vast.nix { };
      });

      devShells = forAll (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.vale
            self.packages.${pkgs.stdenv.hostPlatform.system}.mdx2vast
            pkgs.shellcheck
            pkgs.actionlint
            pkgs.nixfmt
            pkgs.yq-go
            pkgs.jq
          ];
        };
      });

      formatter = forAll (pkgs: pkgs.nixfmt);
    };
}
