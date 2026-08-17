<!-- markdownlint-disable -->

# Hardening Report: digitalocean--action-doctl/v2.5.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **digitalocean--action-doctl/v2.5.2** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple `uses:` references in workflow files are pinned to mutable tags rather than full 40-character SHA commits, making them vulnerable to supply-chain attacks if the tag is moved.

Failing references in .github/workflows/workflow.yml:
- `uses: actions/checkout@v5` (appears 5 times)

Failing references in .github/workflows/pr-label-gate.yml:
- `uses: actions/github-script@v7`

All of these should be replaced with their corresponding full SHA commit hashes (e.g. `actions/checkout@<40-char-sha> # v5`).

Locations:

- `.github/workflows/workflow.yml:9`
- `.github/workflows/workflow.yml:15`
- `.github/workflows/workflow.yml:30`
- `.github/workflows/workflow.yml:46`
- `.github/workflows/workflow.yml:63`
- `.github/workflows/pr-label-gate.yml:11`

### missing-permissions (severity: medium)

Neither `.github/workflows/workflow.yml` nor `.github/workflows/pr-label-gate.yml` declares a top-level `permissions:` key, and no individual job within either file declares its own `permissions:` block. Without explicit permissions, workflows inherit the default repository permissions (which may be `write-all` for private repos or broad for public repos). A minimal `permissions: {}` or specific scopes (e.g. `contents: read`) should be declared at the top level of each workflow.

Locations:

- `.github/workflows/workflow.yml:1`
- `.github/workflows/pr-label-gate.yml:1`

### script-injection (severity: high)

Sub-rule (a): The `ci_success` job's `run:` block in `workflow.yml` directly interpolates GitHub Actions expressions into shell commands. The following expressions are expanded by the template engine before the shell ever sees the script, allowing an attacker to inject arbitrary shell commands via a crafted PR or event payload:

- `NEEDS_JSON='${{ toJson(needs) }}'` — needs context injected into a shell variable assignment
- `if [[ "${{ github.event_name }}" == "pull_request" ...` — github.event_name interpolated into a shell conditional
- `"${{ github.event.pull_request.head.repo.full_name }}"` — attacker-controlled PR head repo name interpolated directly into shell
- `"${{ github.repository }}"` — repository name interpolated into shell

These should be moved to `env:` variables and the shell should reference those env vars instead (e.g. `env: EVENT_NAME: ${{ github.event_name }}` then `"$EVENT_NAME"` in the script).

Locations:

- `.github/workflows/workflow.yml:89`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions, script-injection

**Notes:**

Fixed all three findings across both workflow files:

1. **unpinned-uses**: Pinned all 5 `actions/checkout@v5` references in workflow.yml to SHA `93cb6efe18208431cddfb8368fd83d5badbf9bfd # v5`, and pinned `actions/github-script@v7` in pr-label-gate.yml to SHA `f28e40c7f34bde8b3046d885e986cb6290c5673b # v7`.

2. **missing-permissions**: Added `permissions: contents: read` to workflow.yml (minimum needed for checkout) and `permissions: pull-requests: read` to pr-label-gate.yml (minimum needed to read PR labels).

3. **script-injection**: In the `ci_success` job in workflow.yml, moved all four `${{ }}` expressions out of the `run:` shell script into an `env:` block (`NEEDS_JSON`, `EVENT_NAME`, `PR_HEAD_REPO`, `GITHUB_REPOSITORY_NAME`). The shell script now references these as plain environment variables, preventing injection of attacker-controlled values.

