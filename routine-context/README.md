# routine-context

Copies of the context files the **Morning AES brief** Routine reads, gathered in one folder so a
scheduled task can be pointed at a single place instead of at paths spread through the repo.

| File | Source | Why the Routine needs it |
|---|---|---|
| `watchlist.md` | `context/watchlist.md` | STEP 1 of the prompt. Pre-deal leads, thread markers, nudge dates. |
| `active-projects.md` | `context/active-projects.md` | STEP 3 of the prompt. Open items and live project work the mailbox will not surface. |

That is the complete list. The prompt reads no other repo file. Verified against
`references/routines/morning-brief.md` on 2026-08-11.

## These are generated. Do not edit them.

Each copy carries a header stamping its source, the commit it was taken from, and the date. Edits
typed into a copy are lost the next time anyone syncs. Edit the file under `context/`, then run:

```
./routine-context/sync.sh
```

The script re-copies every source and re-stamps the headers. It fails loudly if a source has moved.

## Before you use this folder, check whether you need it

If the folder named `AES-Company` on your Mac **is the git clone of this repo**, you do not need
these copies. The originals are already sitting in it at `context/watchlist.md` and
`context/active-projects.md`. Point the scheduled task at those and skip this folder entirely. A
second copy of a file you edit weekly is a drift bug waiting to happen.

This folder earns its place in one case only: the local folder is **not** the clone, and you need
the two files somewhere a local task can reach without git. Then copy the folder across:

```
cp -R /path/to/aes-company/routine-context "/path/to/AES-Company/"
```

Re-run that copy whenever the sources change. Nothing automates it.

## The skill is not in here

The Routine also loads the `morning` skill from `.claude/skills/morning/`. It is not duplicated
into this folder, because a skill directory sitting under a context folder loads nowhere and only
confuses the picture. Cloud Routines load it from the cloned repo. Cowork scheduled tasks load it
from your claude.ai account skills, where `morning` is already enabled.
