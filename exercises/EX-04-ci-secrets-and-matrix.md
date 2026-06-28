# EX-04: CI Secrets as Environment Variables

## Use This After

- [LAB-02: Real CI Workflow](../labs/LAB-02-real-ci-workflow.md)
- preferably [EX-03: CI Matrix Across OS and Python](EX-03-ci-matrix.md)

## Workflow To Modify

- `.github/workflows/02-ci.yml`

## Safe Starting Point

Start from the clean `LAB-02` version of `.github/workflows/02-ci.yml`.

If your `EX-02` or `EX-03` version already works, you may continue from that file instead.

## Goal

Practice the most common beginner-safe secrets pattern:

1. store a secret in GitHub
2. map it into `env:`
3. use it in a step

This exercise extends the CI workflow without turning it into a second matrix lesson.

## Challenge

Modify `.github/workflows/02-ci.yml`.

Create one harmless repository secret named:

`TRAINING_MESSAGE`

Use a safe value such as:

`Keep shipping carefully`

## Requirements

- Keep the same test step from `LAB-02`.
- Read `TRAINING_MESSAGE` from GitHub secrets.
- Map it into `env:` for one step.
- Use the secret in a way that proves the workflow received it.
- Do not print the raw secret value in the logs.

## Suggested Pattern

Use one step that:

- checks whether the environment variable is empty
- fails with a clear message if the secret is missing
- prints only a safe confirmation such as:
  - `Training message is present`

## Acceptance Criteria

- The workflow still lives inside `.github/workflows/02-ci.yml`.
- The run fails clearly if the secret is missing.
- The run succeeds when the secret exists.
- The logs do not reveal the secret value itself.
- You can explain the difference between:
  - a GitHub secret
  - a workflow environment variable
  - a normal configuration value
