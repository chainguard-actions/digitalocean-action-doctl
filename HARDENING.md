<!-- markdownlint-disable -->

# Hardening Report: digitalocean--action-doctl/v2.5.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **digitalocean--action-doctl/v2.5.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow uses `actions/checkout@master` — a mutable branch reference — in all six jobs. If the `actions/checkout` repository is compromised or the `master` branch is force-pushed, malicious code would automatically execute in every workflow run. Each `uses:` reference must be pinned to a full 40-character commit SHA (e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`).

Locations:

- `.github/workflows/workflow.yml:9`
- `.github/workflows/workflow.yml:14`
- `.github/workflows/workflow.yml:22`
- `.github/workflows/workflow.yml:35`
- `.github/workflows/workflow.yml:50`
- `.github/workflows/workflow.yml:68`

### missing-permissions (severity: medium)

The workflow file `.github/workflows/workflow.yml` has no top-level `permissions:` key and no job-level `permissions:` block on any of its six jobs (`lint`, `package_check`, `test`, `test_no_auth`, `test_custom_version_linux_and_mac`, `test_custom_version_windows`). The workflow is also triggered by `pull_request_target`, which runs with write repository permissions by default. Without explicit minimal permissions, every job inherits the default broad token scopes, increasing the blast radius of any compromise. A `permissions: {}` block (or specific minimal scopes) should be added at the top level or on each job.

Locations:

- `.github/workflows/workflow.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

1. Pinned all 6 occurrences of `actions/checkout@master` to the full commit SHA `actions/checkout@61b9e3751b92087fd0b06925ba6dd6314e06f089 # master` in `.github/workflows/workflow.yml`. 2. Added `permissions: {}` at the top level of the workflow to restrict all jobs to no permissions by default, mitigating the risk from the `pull_request_target` trigger which otherwise grants write permissions.

