# EX-06: CI Then Build Artifact With `needs`

## Problem Statement

This is a Day 2 bridge challenge based mainly on `LAB-02`.

The team now wants one manual workflow that combines:

- the CI verification idea from `LAB-02`
- the packaging idea that Day 2 will explore in more detail

The rule is simple:

the packaging job must wait until the CI job succeeds.

## How to Use This Challenge

This is a guided Day 2 bridge challenge.

Use it with your instructor right after the recap.

The goal is to connect Day 1 CI ideas to Day 2 packaging ideas.

It is not meant to replace `LAB-03`.

## Related Core Lab

Use this after:

- [LAB-02: Real CI Workflow](../labs/LAB-02-real-ci-workflow.md)

Do not start with this exercise.

Finish `LAB-02` first, then use this challenge at the beginning of Day 2 as a bridge into packaging.

After that, continue to:

- [LAB-03: Build Artifact Workflow](../labs/LAB-03-build-artifact-workflow.md)

## Concepts It Reinforces

- `needs`
- multi-job workflow structure
- fixed matrix
- reusing the CI story before packaging
- unique artifact naming per matrix run

## Challenge Workflow

Prepared workflow file:

`.github/workflows/04-ci-then-build-artifact-exercise.yml`

## What to Notice

Look for:

- a first job that runs the same CI idea as `LAB-02`
- a second job that previews the Day 2 packaging story and waits by using `needs`
- a fixed matrix with Python `3.11` and `3.12`
- a Docker build that uses the matrix value to choose the Python base image
- one uploaded artifact per Python version

## Success Check

You are done when you can explain:

- why the build job should not start before CI passes
- what `needs` changed in the workflow behavior
- what the matrix repeated and what changed in each package
- why each artifact name should stay unique per Python version
