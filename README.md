# zeabur-oss skills

Agent skills shared by every zeabur-oss repository, in the [Agent Skills](https://agentskills.io/) format. Put one in a repository's `.claude/skills/` either way:

```sh
# copy the directory from a clone of this repository
mkdir -p <repo>/.claude/skills
cp -R skills/zeabur-writing <repo>/.claude/skills/
# or with the skills CLI, which also records it in skills-lock.json
npx skills add zeabur-oss/skills --skill zeabur-writing --agent claude-code --copy
```

Without `--copy`, the CLI keeps the skill in `.agents/skills/` and links it from `.claude/skills/`.

A zeabur-oss repository's `.github/workflows/skills.yml` calls the shared [`skills.yml`](https://github.com/zeabur-oss/.github/blob/main/.github/workflows/skills.yml) every week: it copies each directory in `.claude/skills` with the name of a skill here again and opens a pull request. A repository's own skill keeps its commands, paths and terms, has a name not used here, and points to the shared skill for the rest.

## Skills

| Skill | Use it to |
|---|---|
| [`zeabur-writing`](skills/zeabur-writing/SKILL.md) | Write or review docs, interface strings and translations in English, zh-TW and zh-CN, with a Vale style that checks them |
| [`zeabur-oss-workflow`](skills/zeabur-oss-workflow/SKILL.md) | Branch, commit with a DCO sign-off, open and squash-merge pull requests, release, file issues |
| [`zeabur-oss-dependencies`](skills/zeabur-oss-dependencies/SKILL.md) | Add or update a Rust crate or Bun package under the shared supply-chain policy |
| [`zeabur-oss-spec-work`](skills/zeabur-oss-spec-work/SKILL.md) | Implement security- or protocol-relevant behaviour from the specification, with citations and adversarial tests |
| [`zeabur-oss-cluster-tests`](skills/zeabur-oss-cluster-tests/SKILL.md) | Run and write Kubernetes integration and end-to-end tests on a disposable cluster in a VM |
| [`zeabur-oss-ci`](skills/zeabur-oss-ci/SKILL.md) | Understand the shared CI and release workflows and investigate a failed run |
| [`zeabur-oss-rust`](skills/zeabur-oss-rust/SKILL.md) | Follow the conventions every zeabur-oss Rust workspace shares |
| [`zeabur-oss-standards`](skills/zeabur-oss-standards/SKILL.md) | Review a change against the shared engineering standards |
| [`no-ai-flavour`](skills/no-ai-flavour/SKILL.md) | Keep code comments, copy and visuals free of the generic AI-made feel |
| [`story-writing`](skills/story-writing/SKILL.md) | Write or revise a blog post, launch note, technical article or other long-form piece |

## Checking text with Vale

`zeabur-writing` ships a [Vale](https://vale.sh) style in [`skills/zeabur-writing/vale`](skills/zeabur-writing/vale). Its [SKILL.md](skills/zeabur-writing/SKILL.md) says how to set it up in a repository. This flake builds `mdx2vast`, which Vale needs for `.mdx` files:

```nix
inputs.oss-skills.url = "github:zeabur-oss/skills";
# in the dev shell:
packages = [ pkgs.vale oss-skills.packages.${system}.mdx2vast ];
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Licensed under the [Apache License 2.0](LICENSE).
