<!-- markdownlint-disable -->

# Hardening Report: digitalocean--action-doctl/v2.4.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **digitalocean--action-doctl/v2.4.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow uses `actions/checkout@master` — a mutable branch reference — in every job instead of a pinned 40-character commit SHA. If the `master` branch of `actions/checkout` is compromised or force-pushed, all jobs will silently execute the attacker's code. All five `uses: actions/checkout@master` occurrences must be replaced with a full SHA pin (e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`).

Locations:

- `.github/workflows/workflow.yml:9`
- `.github/workflows/workflow.yml:14`
- `.github/workflows/workflow.yml:28`
- `.github/workflows/workflow.yml:42`
- `.github/workflows/workflow.yml:57`

### missing-permissions (severity: medium)

The workflow file has no top-level `permissions:` key and no job-level `permissions:` key on any of its five jobs (lint, package_check, test, test_custom_version_linux_and_mac, test_custom_version_windows). Without explicit permissions, GitHub grants the default token permissions (which can be write-all depending on repository settings). This is especially risky because the workflow is triggered by `pull_request_target`, which runs with write access to the base repository even for PRs from forks. A minimal `permissions:` block (e.g. `contents: read`) should be added at the top level or per job.

Locations:

- `.github/workflows/workflow.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

1. Pinned all 5 occurrences of `actions/checkout@master` to the full commit SHA `61b9e3751b92087fd0b06925ba6dd6314e06f089` (with `# master` comment for readability). 2. Added a top-level `permissions: contents: read` block to enforce least-privilege access, which is especially important given the workflow is triggered by `pull_request_target`.

