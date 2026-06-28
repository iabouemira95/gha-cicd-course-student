# Configure Registry, SSH, and GitHub Secrets

## Purpose

This page shows the minimum setup needed before the final assessment workflows can run.

## GitHub Secrets to Create

For this course, create these repository secrets:

- `DEPLOY_HOST`
- `DEPLOY_USER`
- `DEPLOY_SSH_KEY`
- `REGISTRY_HOST`
- `REGISTRY_USERNAME`
- `REGISTRY_PASSWORD`

Open:

`Settings -> Secrets and variables -> Actions -> Secrets`

Create the secrets listed above in this page.

## Registry Setup

You need:

- one container registry host
- one registry username
- one registry password or token
- one repository named `tiny-health-app`

Use:

- your registry login server for `REGISTRY_HOST`
- your registry username for `REGISTRY_USERNAME`
- your registry password or token for `REGISTRY_PASSWORD`

The workflow uses them to push the built image.

Keep the repository name exactly `tiny-health-app` for this course.

Your instructor will tell you what registry service is used in your cohort. The assessment docs stay generic so the workflow shape remains the main lesson.

## SSH Key Setup

Generate a key pair if you do not already have one:

```bash
ssh-keygen -t ed25519 -C "gha-course-assessment"
```

Then:

1. add the public key to the host user's `~/.ssh/authorized_keys`
2. add the private key content to `DEPLOY_SSH_KEY` in GitHub secrets

## VM Values

Use:

- the host IP address or DNS name for `DEPLOY_HOST`
- the host login name for `DEPLOY_USER`

Use a public host value here, because the workflow validates the deployed app from GitHub Actions after the remote deploy step finishes.

## Quick Local Check

These commands run from your own machine, not inside the GitHub browser.

Before you run the workflow, check SSH once from your machine:

```bash
ssh <vm-user>@<vm-host>
```

If this login does not work, fix it before you open the workflow.

If you want one quick local support check before the lab, you can also run:

```bash
bash scripts/assessment/prepare-local-machine.sh
```

If you want the full local Ubuntu dependency check directly, run:

```bash
bash scripts/install-assessment-deps.sh --check-only
```

## What Should Be True Before You Run LAB-07 or EX-12

Before you run `LAB-07` and later build the final assessment workflows, all items below should be true:

- the host accepts SSH key login
- the host is reachable on port `8000`
- the deploy-host secrets are saved
- one manual SSH login from your machine has already worked
- you understand that external browser access also depends on VM and cloud firewall rules

- the registry repository exists
- the registry secrets are saved

## Why This Matters

This setup gives the workflow exactly what it needs:

- registry access to push the image
- SSH access to reach the host
- one clear remote target for deployment

## Next Step

After this page, continue with:

1. [LAB-07: Final Assessment Setup and Validation Prep](../../labs/LAB-07-docker-hub-vm-deploy.md)
2. [Assessment Success Criteria, Validation, and Rubric](05-success-criteria-and-rubric.md)
