# EX-08: CI Then Build Artifact With `needs`

## Use This After

- [LAB-03: Build Artifact Workflow](../labs/LAB-03-build-artifact-workflow.md)
- preferably [EX-07: Build Artifact Scan with Trivy](EX-07-build-artifact-scan-with-trivy.md)

## Workflow To Modify

- `.github/workflows/03-build-artifact.yml`

## Safe Starting Point

Start from the clean `LAB-03` version of `.github/workflows/03-build-artifact.yml`.

If your `EX-06` or `EX-07` version already works, you may continue from that file instead.

## Goal

Strengthen the build workflow so it shows two clear phases:

1. verify runs first
2. packaging runs second

The packaging job must wait for CI by using `needs`.

## Challenge

Continue modifying `.github/workflows/03-build-artifact.yml`.

## Requirements

- The workflow should have one verification job and one packaging job.
- The verification job should reuse the same test idea from `LAB-03`.
- The packaging job should wait for CI by using `needs`.
- The packaging job should still produce a saved artifact.

## Acceptance Criteria

- The Actions view shows verification first and packaging second.
- Packaging does not start before CI succeeds.
- The artifact still appears only after packaging finishes.
- The changes still live inside `.github/workflows/03-build-artifact.yml`.
- You can explain what `needs` changed in the workflow behavior.
