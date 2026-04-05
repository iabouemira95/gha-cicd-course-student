# EX-08: Build and Run With GitHub Variables

## Problem Statement

This is a challenge based on `LAB-04`.

In the main deploy lab, the workflow used a saved artifact from an earlier workflow.

This challenge keeps the path smaller on purpose:

- build the image
- start the container
- check the app

All of that happens on the same runner in one job.

The new GitHub Actions idea is reading normal configuration from GitHub repository variables.

This is a focused configuration exercise.

It is useful for practice, but it does not replace the main lab story of deploying the saved artifact from an earlier workflow.

## Related Core Lab

Use this after:

- [LAB-04: Deploy Workflow](../labs/LAB-04-deploy-workflow.md)

Do not start with this exercise.

Finish `LAB-04` first, then use this challenge to practice one small configuration idea in a simpler build-and-run flow.

## Concepts It Reinforces

- build and run on the same runner
- single-job workflow flow
- Dockerfile `ARG`
- GitHub repository variables with `vars`
- non-secret configuration values

## Before You Run the Workflow

Create normal repository variables for this exercise.

Do not use secrets.

Do not use GitHub environments for this exercise.

Go to:

`Settings -> Secrets and variables -> Actions -> Variables`

Create:

- `PYTHON_BASE_IMAGE` = `python:3.12-slim`
- `APP_PORT` = `8000`

## Challenge Files

Prepared files:

- `.github/workflows/04-build-and-run-with-vars-exercise.yml`
- `Dockerfile.arg-base`

## What to Notice

Look for:

- one job that does both build and run
- `${{ vars.PYTHON_BASE_IMAGE }}` and `${{ vars.APP_PORT }}`
- a check step that fails clearly if a variable is missing
- `--build-arg BASE_IMAGE=...` in the Docker build step
- the health check after the container starts

## Success Check

You are done when you can explain:

- what changed compared with `LAB-04`
- how `vars` is different from workflow `env`
- why `PYTHON_BASE_IMAGE` and `APP_PORT` are variables, not secrets
- how the workflow reused settings values during both build and run
