# skills

Agent skills I wrote for myself.

This repository is checked out as `~/.agents/skills`, the folder agents load skills from. The skills CLI installs third-party skills into the same folder, so `.gitignore` ignores every skill folder except my own. When adding a skill, add `!/<name>/` to `.gitignore`.

## Set up a new machine

```sh
git clone git@github.com:micksmits/skills.git ~/.agents/skills
~/.agents/skills/third-party.sh
```

Third-party skills stay with their publishers. `third-party.sh` installs them from their original sources, and `npx skills update -g` keeps them current.

Don't run `npx skills add micksmits/skills -g` on a machine with this checkout: it would install over the skill folders here.

## Adapted skills

`full-send` and `full-stop` come from Theo Browne's [t3dotgg/tstack](https://github.com/t3dotgg/tstack) (MIT, license in each folder), adapted to use my `pr` skill instead of tstack's `sol-loop`, `file-pr` and `babysit-pr`.
