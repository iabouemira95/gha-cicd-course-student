# Assessment Success Criteria, Validation, and Rubric

## Purpose

This page gives clear and observable checks for the final assessment.

Use it as the final reference for:

- what success looks like
- what should already be ready before `EX-12`
- what command to run after deployment
- what should be visible in the workflow
- what should be visible in the deployed app

## Before You Start EX-12

Confirm all of these are already true:

- you completed `LAB-05`
- you completed `EX-05`
- you completed `EX-11`
- you completed `LAB-07`
- you have a local shell on your own machine for `scp`, `ssh`, and local validation commands
- you have a local copy of this repository, or at least the assessment script files available locally
- your target Linux host accepts SSH key login
- port `8000` is reachable on the host
- Docker works on the host
- your registry repository `tiny-health-app` exists
- all six required GitHub secrets are saved

## Core Success Categories

### 1. Verification

- opening or updating a pull request to `main` starts the CI path
- the CI quality gate passes
- the student can point to the test, lint, and scan steps
- the branch protection rule requires the CI quality gate before merge

### 2. Deployable Output and Traceability

- the CD workflow prepares one clear Docker image as the deployable output
- the image reference is shown clearly in the logs
- the image is pushed to the registry successfully

### 3. Remote Deployment

- the remote host is reached over SSH
- the remote host pulls the same image that was pushed earlier
- the container starts on the remote host successfully

### 4. Running Application Checks

- `/health` responds successfully
- `/version` responds with build details such as `app_version`, `commit_sha`, and `image_tag`
- `/status` responds with runtime visibility such as `app_version`, `commit_sha`, `image_tag`, `environment`, and `deployment_mode`

### 5. Explanation

- the student can explain what exact thing was deployed
- the student can explain which image tag was deployed
- the student can explain why this deployment is repeatable
- the student can explain how this extends `code -> verify -> package -> deliver`

## Beginner-Friendly Rubric

Use this simple rubric:

| Category | What a passing result looks like |
|---|---|
| verification | PR CI runs tests, linting, and scans successfully |
| output | one clear deployable output is prepared and traceable |
| deployment | the remote host runs the intended updated container |
| validation | the app responds on the expected port and endpoints |
| explanation | the student can describe the deployed output clearly |

## A Fair Pass Standard

A fair beginner pass means:

- the CI and CD workflows work end to end
- the required PR status check is visible and understandable
- the app is reachable on the expected port
- the status endpoints show useful deployment details
- the student can explain what was deployed and why the flow is trustworthy

## Observable Evidence

When you or your instructor review the result, these are the clearest things to point to:

- the passing `verify` job
- the visible PR CI quality gate result before merge
- the image reference shown in the workflow logs
- the running app responses from `/health`, `/version`, and `/status`
- one clear explanation of what exact thing is now running on the remote host

## Final Validation Command

After the CD workflow succeeds, run this from your repository root on your own machine:

```bash
bash scripts/assessment/validate-deployment.sh http://<vm-host>:8000
```

Replace `<vm-host>` with the same public host value you saved in `DEPLOY_HOST`.

That validation script checks:

- `/health`
- `/version`
- `/status`
- the required JSON fields used in this assessment path

## Final Self-Check

You are done when all of these are true:

- the workflows pass end to end
- the pull request gate is visible before merge
- the deployed app responds on port `8000`
- the homepage at `/` is reachable from a browser after the VM exposure path is correct
- the validation command passes
- you can explain what exact image was deployed
- you can explain why the flow is repeatable
- you can explain how the final workflow still follows `code -> verify -> package -> deliver`
