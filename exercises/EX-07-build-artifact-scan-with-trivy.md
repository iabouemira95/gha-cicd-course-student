# EX-07: Build Artifact Scan with Trivy

## Use This After

- [LAB-03: Build Artifact Workflow](../labs/LAB-03-build-artifact-workflow.md)
- preferably [EX-06: Build Artifact with Buildx](EX-06-build-artifact-with-buildx.md)

## Workflow To Modify

- `.github/workflows/03-build-artifact.yml`

## Safe Starting Point

Start from the clean `LAB-03` version of `.github/workflows/03-build-artifact.yml`.

If your `EX-06` Buildx version already works, you may continue from that file instead.

## Goal

Add one more packaging safeguard:

scan the built image tar before you upload it as the artifact.

This keeps the same build workflow story:

verify -> package -> inspect the package -> save the package

## Challenge

Modify `.github/workflows/03-build-artifact.yml`.

## Requirements

- Keep the build workflow focused on one packaged image tar.
- Add one Trivy step that scans the built artifact tar before upload.
- Keep the scan step readable and clearly named.
- Keep the artifact upload after the scan.

## Acceptance Criteria

- The workflow still builds the image tar.
- The workflow clearly scans that tar before upload.
- The artifact upload still happens after the scan step.
- The changes still live inside `.github/workflows/03-build-artifact.yml`.
- You can explain why scanning the packaged output is different from scanning the source files.
