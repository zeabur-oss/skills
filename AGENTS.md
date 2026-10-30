# AGENTS.md

Agent skills shared by every zeabur-oss repository. Each skill is a directory that the `skills` CLI copies into a repository as it is.

## Layout

```
skills/<name>/SKILL.md     the skill: frontmatter, then instructions
skills/<name>/*.md         references SKILL.md links to, loaded when needed
skills/zeabur-writing/vale the Vale style, its TypeScript view and the sample vale.ini
tests/zeabur-writing/      Vale fixtures: hit/ must trigger the rule named on line 1, clean/ nothing
scripts/ci.sh              the CI jobs (--list)
```

## Writing a skill

- The directory name is kebab-case and equals `name` in the frontmatter. `description` says what the skill does and when to use it, with the words a request would contain.
- A shared skill holds what is the same in every repository. Commands, paths, crate names and term lists stay in that repository's own skill, which points here.
- Merge facts from the repositories; do not invent a rule none of them has.
- Write by `zeabur-writing`: plain words, no filler, no caveat that does not change what the reader does.
- `no-ai-flavour` and `story-writing` are kept as their author wrote them; change them only when asked.

## Changing the Vale style

- A new rule gets a fixture in `tests/zeabur-writing/hit/` that triggers it and nothing else. A false positive you fix goes into a file under `clean/`.
- A file's locale comes from its path (`zh-TW`, `zh-CN`, `i18n/en.ts`), as in `vale/vale.ini`. `.vale.ini` at the root is the same file with this repository's `StylesPath`; keep them equal.

## Checks

Run every job before you commit, in the dev shell (`nix develop`):

```sh
./scripts/ci.sh skills   # frontmatter of each SKILL.md
./scripts/ci.sh lint     # shellcheck, actionlint, nixfmt
./scripts/ci.sh prose    # Vale fixtures, then Vale on this repository's own text
```

Commits follow [CONTRIBUTING.md](CONTRIBUTING.md).
