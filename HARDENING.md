<!-- markdownlint-disable -->

# Hardening Report: digitalocean--action-doctl/v2.5.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **digitalocean--action-doctl/v2.5.1** was hardened automatically. 2 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

All 6 `uses:` references in the workflow use `actions/checkout@master` — a mutable branch name rather than a pinned 40-character commit SHA. An attacker who compromises the `actions/checkout` repository (or its `master` branch) could inject malicious code into every workflow run. Each job (lint, package_check, test, test_no_auth, test_custom_version_linux_and_mac, test_custom_version_windows) contains an unpinned reference. All should be replaced with a full SHA, e.g. `actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683 # v4`.

Locations:

- `.github/workflows/workflow.yml:9`
- `.github/workflows/workflow.yml:14`
- `.github/workflows/workflow.yml:22`
- `.github/workflows/workflow.yml:34`
- `.github/workflows/workflow.yml:47`
- `.github/workflows/workflow.yml:60`

### missing-permissions (severity: medium)

The workflow file `.github/workflows/workflow.yml` has no top-level `permissions:` key and none of its 6 jobs (lint, package_check, test, test_no_auth, test_custom_version_linux_and_mac, test_custom_version_windows) define job-level `permissions:` blocks. Without explicit permissions, the workflow inherits the repository's default token permissions, which may be overly broad (write access to contents, pull-requests, etc.). A minimal permissions block such as `permissions: read-all` or specific scopes should be added.

Locations:

- `.github/workflows/workflow.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

1. Pinned all 6 `uses: actions/checkout@master` references in .github/workflows/workflow.yml to the full commit SHA `61b9e3751b92087fd0b06925ba6dd6314e06f089`, preserving `# master` as a comment for readability. 2. Added `permissions: read-all` at the top level of the workflow file to replace the implicit (potentially broad) default token permissions.

### Iteration 2

**Fixes applied:** broad-permissions

**Notes:**

Replaced `permissions: read-all` with specific minimal permissions `contents: read` in `.github/workflows/workflow.yml`. The workflow only requires read access to repository contents for checkout and git diff operations, so `contents: read` is sufficient.

