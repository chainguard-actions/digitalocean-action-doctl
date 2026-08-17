<!-- markdownlint-disable -->

# Hardening Report: digitalocean--action-doctl/v2.4.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **digitalocean--action-doctl/v2.4.1** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

The workflow file uses `actions/checkout@master` (a mutable branch name) in all 5 step references instead of a pinned 40-character commit SHA. This means the action could be silently updated to a malicious version without any change to the workflow file. All occurrences should be replaced with a full SHA pin, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # master`.

Locations:

- `.github/workflows/workflow.yml:9`
- `.github/workflows/workflow.yml:16`
- `.github/workflows/workflow.yml:24`
- `.github/workflows/workflow.yml:38`
- `.github/workflows/workflow.yml:60`

### missing-permissions (severity: medium)

The workflow file `.github/workflows/workflow.yml` has no top-level `permissions:` key and no job-level `permissions:` key on any of its 5 jobs (lint, package_check, test, test_custom_version_linux_and_mac, test_custom_version_windows). Without explicit permissions, the workflow inherits the default repository permissions (which can be `write-all` for private repos or repos with permissive defaults), granting unnecessary access. A minimal `permissions:` block (e.g. `contents: read`) should be added at the top level or per job.

Locations:

- `.github/workflows/workflow.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 5 occurrences of `actions/checkout@master` by replacing them with `actions/checkout@61b9e3751b92087fd0b06925ba6dd6314e06f089 # master` (resolved via lookup_action_sha). Added a top-level `permissions: contents: read` block to enforce least-privilege access across all 5 jobs (lint, package_check, test, test_custom_version_linux_and_mac, test_custom_version_windows).

