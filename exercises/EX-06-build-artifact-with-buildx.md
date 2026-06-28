# EX-06: Build Artifact with Buildx

## Use This After

- [LAB-03: Build Artifact Workflow](../labs/LAB-03-build-artifact-workflow.md)

## Workflow To Modify

- `.github/workflows/03-build-artifact.yml`

## Safe Starting Point

Start from the clean `LAB-03` version of `.github/workflows/03-build-artifact.yml`.

If you already have a working build exercise version, you may continue from that file instead.

## Goal

Keep the same packaging story from `LAB-03`, but use reusable Docker actions instead of raw Docker commands where possible.

This exercise keeps the same packaging goal from `LAB-03` and changes only the build implementation style.

## Challenge

Modify `.github/workflows/03-build-artifact.yml`.

If you need syntax help, use [Finding and Reusing GitHub Actions](../docs/help/07-finding-and-reusing-actions.md).

## Requirements

- Keep the same overall story from `LAB-03`.
- Run the tests before packaging.
- Use Buildx-based reusable actions instead of the raw Docker command path.
- Export the image as a tar file.
- Upload that tar file as the artifact.

## Acceptance Criteria

- The workflow still shows tests first, then packaging.
- The workflow produces a tar file as the packaged output.
- The tar file is uploaded as the artifact.
- The change still lives inside `.github/workflows/03-build-artifact.yml`.
- You can explain what stayed the same from `LAB-03`.
- You can explain what reusable actions replaced.
