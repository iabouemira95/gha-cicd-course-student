# Next Steps: Matrix and Secrets

## Purpose

This page introduces two common GitHub Actions ideas that are useful after the beginner core of this course:

- matrix builds
- secrets management

These are next-step topics, not the first ideas you need on Day 1.

## Why These Topics Are Not in the Main Labs

The main course stays focused on one clear story:

1. code
2. verify
3. package
4. deliver

Matrix builds and secrets are valuable, but they add more moving parts.

It is better to learn them after the core story feels stable.

## Matrix Builds

### Short Answer

A matrix lets one workflow run the same job in multiple variations.

Examples:

- more than one Python version
- more than one operating system

### Why Teams Use It

It helps teams answer questions like:

- Does the app work on Python 3.11 and 3.12?
- Does the test suite pass on Linux and Windows?

### Practice Path

If you want to practice that idea in this repository, continue with:

- [EX-03: CI Matrix Across OS and Python](../exercises/EX-03-ci-matrix.md)

That exercise keeps the same CI workflow shape while repeating it across:

- Ubuntu and Windows runners
- Python `3.11` and `3.12`

## Secrets Management

### Short Answer

A secret is a sensitive value such as:

- API token
- password
- deployment key

In GitHub Actions, secrets should be stored in GitHub settings, not written directly in workflow files.

### Beginner-Safe Practice Path

If you want to practice the simplest useful secrets pattern in this repository, continue with:

- [EX-04: CI Secrets as Environment Variables](../exercises/EX-04-ci-secrets-and-matrix.md)

That exercise teaches this pattern:

1. store a secret in GitHub
2. map it into `env:`
3. use it safely in a workflow step

### Beginner Safety Rules

- never write real secrets directly in the repository
- never commit passwords or tokens
- do not print secrets in logs
- treat secrets as protected inputs, not normal text values

## Variables, Environment Variables, and Secrets

Use this short rule:

- GitHub Actions variable = normal configuration value stored in repository settings
- environment variable = reusable value written inside the workflow YAML
- secret = sensitive value that must be protected

Examples of values that usually fit `vars` better than `secrets`:

- port numbers
- image names
- Python base image tags

## When to Learn These Next

Learn these after you are comfortable with:

- reading workflow runs
- understanding triggers
- understanding jobs and steps
- explaining the main CI/CD story

## Related Pages

- [CI vs CD](05-ci-vs-cd.md)
- [Trigger Reference](help/06-trigger-reference.md)
- [Finding and Reusing GitHub Actions](help/07-finding-and-reusing-actions.md)
- [Glossary](help/03-glossary.md)
- [Full Containerized CI/CD Example](07-full-containerized-cicd-example.md)
