# Contributing

## Developer Certificate of Origin

This project uses the [Developer Certificate of Origin 1.1](DCO). Sign off every commit to
certify that you wrote it or otherwise have the right to submit it under the
[Apache License 2.0](LICENSE):

```sh
git commit -s
```

CI rejects pull requests whose commits lack a `Signed-off-by` line matching the author. Commit
messages follow [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`,
`docs:`, `ci:`, `chore:`). Pull requests are squash-merged, so the pull request title is the commit
message on `main` and follows the same form.

## Setup and checks

The development shell (`flake.nix`) has Vale, mdx2vast, shellcheck, actionlint and nixfmt; run
every command in it (`nix develop`, or `nix develop -c <command>`). CI runs every job of
`scripts/ci.sh`, which enters the shell itself:

```sh
./scripts/ci.sh --list     # skills, lint, prose
./scripts/ci.sh prose
```

[AGENTS.md](AGENTS.md) covers how to write a skill and change the Vale style.
