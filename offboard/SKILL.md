---
name: offboard
description: End a session cleanly. Inventory everything the session left behind, clean it up with the user's approval, and hand off a concise description of the expected end state for testing in another session.
disable-model-invocation: true
---

# Offboard

Leave the environment as you found it, plus the intended change, and hand the next session what it needs to test that change. Work from evidence (process lists, `git status`, directory listings, database and log queries), never from memory of what you did.

## 1. Inventory

List every artifact the session created or changed, in every place it touched:

- **Processes:** dev servers, background shells, watchers, tunnels, test runners, including on remote hosts.
- **Remote hosts:** copied releases, temp scripts, browser or driver sessions, config edits and their backups.
- **Data:** test records in local and production databases, queued jobs, changed settings or policies.
- **Git:** local and remote branches, worktrees, uncommitted changes, open PRs.
- **Files:** temp and scratch files, logs, generated artifacts.
- **Access:** browser logins, adopted tabs, credentials written anywhere.

Also record leftovers from earlier sessions that you came across, especially changes to shared or production state such as limits, flags or policies, and whether they have a saved original.

Done when every place the session touched has been checked and each artifact is listed with its location.

## 2. Classify

Sort each artifact:

- **Remove:** the session created it and nothing depends on it.
- **Keep:** something still depends on it; give the reason.
- **User's call:** anything owned by real users, production data the session did not create, anything irreversible, and earlier sessions' changes to shared state. Never change user records without explicit approval.

## 3. Clean up

Show the list as a table of item, location and proposed action, and get approval. Then do the approved actions. Verify each one with a fresh check (the process is gone, the branch is missing on the remote, the file no longer lists). Restore a shared-state change only when it still matches exactly what the earlier change set, and keep its original as the reference.

Done when every item is verified removed, kept with a reason, or left for the user's decision.

## 4. Hand off

Write a summary for whoever tests this in a new session. Describe the end state, not the changes:

- What the feature does from the user's point of view, and how to trigger it.
- What a correct result looks like, with concrete numbers, timings and where to see them (UI, tables, logs).
- How it behaves when something goes wrong, and where errors appear.
- Known limitations, and what has not yet been verified live.
- Anything left for the user to decide.

Keep it to one screen. Include names, URLs, commands and IDs the tester needs; leave out implementation history.
