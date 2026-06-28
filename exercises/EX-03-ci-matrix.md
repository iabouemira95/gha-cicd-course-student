# EX-03: CI Matrix Across OS and Python

## Use This After

- [LAB-02: Real CI Workflow](../labs/LAB-02-real-ci-workflow.md)
- preferably [EX-02: CI Visibility and Schedule](EX-02-ci-visibility-and-schedule.md)

## Workflow To Modify

- `.github/workflows/02-ci.yml`

## Safe Starting Point

Start from the clean `LAB-02` version of `.github/workflows/02-ci.yml`.

If your `EX-02` version already works, you may continue from that file instead.

## Goal

Run the same CI job in a few controlled variations without copying the whole job.

This exercise keeps the same CI story from `LAB-02` and adds one matrix with two dimensions:

- runner operating system
- Python version

## Challenge

Modify `.github/workflows/02-ci.yml`.

## Requirements

- Keep the same test step from `LAB-02`.
- Use a matrix so the job runs on:
  - `ubuntu-latest`
  - `windows-latest`
- Use the same matrix so the job also runs on:
  - Python `3.11`
  - Python `3.12`
- Do not copy the whole job four times.

## Acceptance Criteria

- The Actions view shows repeated CI runs across both operating systems and both Python versions.
- The workflow still lives inside `.github/workflows/02-ci.yml`.
- The test command stays the same while the matrix values change around it.
- You can explain what repeated and what stayed the same.
