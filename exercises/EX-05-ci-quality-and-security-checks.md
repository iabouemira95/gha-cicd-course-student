# EX-05: CI Quality and Security Checks

## Use This After

- [LAB-02: Real CI Workflow](../labs/LAB-02-real-ci-workflow.md)
- preferably [EX-04: CI Secrets as Environment Variables](EX-04-ci-secrets-and-matrix.md)

## Workflow To Modify

- `.github/workflows/02-ci.yml`

## Safe Starting Point

Start from the clean `LAB-02` version of `.github/workflows/02-ci.yml`.

If your earlier CI exercises already work, you may continue from that file instead.

## Goal

Harden the same CI workflow in three small stages:

1. add Ruff linting
2. add a Trivy filesystem scan
3. add a Trivy Dockerfile/config scan

This is still one exercise on the same CI file.

## Mini-Checkpoint 1: Ruff

Add Ruff as a quick code-quality check before packaging ever begins.

### Success Check

- the workflow clearly runs Ruff
- the Actions logs show the Ruff step separately
- the test step still exists

## Mini-Checkpoint 2: Trivy Filesystem Scan

Add a Trivy scan that checks the repository files and configuration from the source tree.

Keep the scan simple and classroom-safe.

Treat it as:

- one more visibility check
- one more thing to read in the CI logs

### Success Check

- the workflow clearly runs a Trivy filesystem scan
- the scan appears as its own step in the Actions UI
- you can explain that it is scanning the repository contents, not the running app

## Mini-Checkpoint 3: Trivy Dockerfile and Config Scan

Add a second Trivy step that checks the Dockerfile and related configuration for simple misconfiguration findings.

Keep this lightweight.

The point is to show how CI can include security-oriented checks, not to build a full policy system.

### Success Check

- the workflow clearly runs a Dockerfile/config scan
- the step has a teaching-friendly name
- you can explain why this scan is different from the filesystem scan

## Acceptance Criteria

- all changes still live inside `.github/workflows/02-ci.yml`
- the workflow now shows:
  - tests
  - Ruff
  - Trivy filesystem scan
  - Trivy Dockerfile/config scan
- each check has a clear step name
- you can explain what each new check is trying to protect

## Partial Success Rule

If you finish Ruff first, that is still valid progress.

Ask your instructor for help before you keep piling on changes if the later Trivy steps become unclear.
