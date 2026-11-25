---
name: pr
description: Create a PR, wait for CodeRabbit's initial review, and report its suggestions. When the user selects suggestions to implement, apply them, babysit CI, merge without another CodeRabbit review cycle, and delete the merged branch.
---

# PR and CodeRabbit review

Deliver a PR link and CodeRabbit's suggested fixes. Leave implementation of those suggestions for the user's decision unless they explicitly request fixes too.

## Publish

1. Inspect repository instructions, the working tree, branch, remote, default branch, and PR template. Identify the task's complete diff, including untracked source files; preserve unrelated work and exclude secrets and local artifacts.
2. Run the relevant checks. Record actual results, skipped checks, and existing blockers for the PR body.
3. Follow the repository's branch naming rules. Move off a placeholder branch before committing or pushing. Stage only the intended files, inspect the staged diff, commit, and push with an upstream.
4. Reuse an existing PR for this branch, or create a ready-for-review PR against the intended base using the repository template. Describe behavior, verification, migrations, and important caveats. Add screenshots for UI changes when available; keep debugging artifacts out of the commit. Write the title and description as described in Writing the PR.

Complete when GitHub returns the PR URL and its head SHA matches the pushed work.

### Writing the PR

PR titles usually become commit messages, so follow the repository's title conventions; look at recently merged PRs and Git history for examples. Prefer a concise, human-readable title that explains why the change matters:

- Bad: `fix(db): use isPersonVisibleToTeam in withPerson and createInteraction`
- Good: `fix(db): let team members open and refresh profiles of funnel leads`

Open the description (in the template's summary section, when there is one) with a simple explanation of the problem, based on the user's original request, then briefly explain the solution. Do not lead with an implementation inventory:

- Bad: "Added `isVisibleToTeam` and `isPersonVisibleToTeam` to `network.ts`. `crm-people.ts` now uses them for profile reads and updates instead of the inline `connections` subquery, and `createInteraction` uses them too."
- Good: "Refreshing a funnel lead's profile failed with 'Person is not in this team's network', because leads from Sales Navigator aren't connections. Team members can now open, refresh and log interactions on their own active leads."

## Wait for CodeRabbit

1. Inspect PR checks, reviews, conversation comments, and inline review comments using GitHub CLI/API. Identify CodeRabbit by its actual bot account, not by arbitrary text mentioning it.
2. Check whether automatic review has started for the current head SHA. If it has not, or the bot explicitly skipped it, request one with `@coderabbitai review` in a PR comment when supported. Request at most once per revision; report configuration, access, or rate-limit blockers rather than repeatedly triggering reviews.
3. Wait for a completed review of the current revision. Prefer the relevant check's watch mechanism; otherwise poll at 20–30 second intervals for up to 15 minutes. A queued check, walkthrough-only comment, or completed review of an older commit is not completion. If the head changes, verify coverage of the new head.
4. After completion, retrieve all pages of bot reviews and comments, including review-thread resolution/outdated state where available. Read the full review body, including actionable suggestions outside inline comments. Separate current findings from resolved, outdated, informational, and optional polish comments.

Complete when the latest revision's review is finished and all its feedback has been read, or a specific timeout/blocker can be reported honestly.

## Report

- Lead with the PR URL and whether CodeRabbit finished reviewing the latest revision.
- List each current suggested fix with its file/line when supplied, a short explanation, reported severity if present, and a link to the source comment or review.
- Distinguish CodeRabbit's suggestions from independently verified bugs. Group optional polish separately and state when there are no actionable findings.
- Mention failing CI checks separately from the bot's recommendations.
- In report-only mode, state that suggestions have not been applied and wait for the user's decision; creating a PR is not authorization to merge or deploy it.

## Fix and merge without another review

Use this branch once the user selects or approves CodeRabbit suggestions to implement, including a brief approval of the reported suggestions. That approval authorizes implementing the selected suggestions, babysitting CI, merging after CI passes, and deleting the merged branch; no separate confirmation is needed. Follow an explicit user restriction such as “fix only” or “leave unmerged” instead.

1. Verify the initial findings against the current code, reproduce valid bugs with regression tests, and apply minimal fixes. Report invalid findings rather than changing code to satisfy them. Optional polish warnings remain separate from the requested bug fixes.
2. Run the relevant checks, commit, and push the fixes. Resolve the original review threads only after verifying the fixes, with a reference to the fixing commit.
3. Babysit CI on the updated head until it passes: watch checks, investigate failures, fix regressions caused by the selected changes, and rerun relevant checks after pushing fixes. Report unrelated failures, access problems, or timeouts as blockers. Disregard second-wave CodeRabbit suggestions: do not request, wait for, or implement another optional review cycle. Respect branch protection if a review check is required, and report blockers rather than bypassing them.
4. Merge the verified head using the repository's permitted merge method and confirm GitHub reports the PR as merged.
5. After GitHub reports the merge, delete the PR branch on `origin` and locally. First switch the checkout to the updated default branch. Delete locally with `git branch -d`, which refuses to delete unmerged commits. If the branch holds commits that are not in the merge, or another worktree has it checked out, keep it and report why.
6. Report the merge result, fixes, verification and branch cleanup. Leave deployment actions to their own authorization.

Complete when GitHub confirms the PR is merged and its branch is deleted, or when a specific blocker prevents merging or deletion.
