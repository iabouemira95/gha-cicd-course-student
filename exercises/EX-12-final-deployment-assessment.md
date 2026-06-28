# EX-12: Final Deployment Assessment

## Use This After

- [LAB-05: Full CI/CD Flow](../labs/LAB-05-full-cicd-flow.md)
- [EX-11: PR-Based CI/CD with Branch Protection](EX-11-pr-based-ci-cd-with-branch-protection.md)
- [LAB-07: Final Assessment Setup and Validation Prep](../labs/LAB-07-docker-hub-vm-deploy.md)

## Goal

Build one final CI/CD workflow that proves you can carry the course story into a more realistic team-style target:

- CI runs on pull requests to `main`
- CI verifies, lints, and scans the app before merge
- that CI becomes the required status check for merge
- after merge to `main`, CD builds, pushes, deploys, and validates the same image

This final exercise builds on `LAB-05`, `EX-11`, and `LAB-07`.

## Workflow To Create

- `.github/workflows/08-final-deployment-assessment.yml`

Start from this guided starter:

- `docs/assessment/starter-workflows/08-final-deployment-assessment-starter.yml`

This is the later exception where you create a new workflow file.

That new file is still derived from earlier lab workflows:

- take the verify idea from `.github/workflows/02-ci.yml`
- take the packaging idea from `.github/workflows/03-build-artifact.yml`
- take the delivery-and-validation idea from `.github/workflows/04-deploy.yml`

Copy the starter into `.github/workflows/08-final-deployment-assessment.yml` and then fill the gaps yourself.

## Requirements

- The workflow should trigger on pull requests to `main`.
- The workflow should also trigger on pushes to `main` after merge.
- The workflow should separate the work into clear jobs such as `verify`, `build-and-push`, and `deploy-to-host`.
- The later jobs should depend on the earlier ones clearly.
- The PR CI job should use one stable visible job name such as `CI quality gate`.
- The PR CI job should run the project tests before packaging or deployment.
- The PR CI job should include Ruff linting.
- The PR CI job should include a Trivy filesystem scan.
- The PR CI job should include a Trivy Dockerfile/config scan.
- The PR CI job should build one local image only for scan visibility and run a Trivy image scan against it.
- The `main` branch should require the PR CI job as a status check before merge.
- The CD path should build the image from the current `Dockerfile`.
- The CD path should push the image to the container registry your instructor provides.
- The workflow logs should show the full image reference clearly.
- The CD path should connect to the Linux host over SSH using GitHub secrets.
- The Linux host can be an Ubuntu VM, an EC2 instance, or another SSH-reachable Linux VM.
- The host should log in to the registry if needed and pull the same image that was pushed earlier.
- The workflow should replace any older container safely.
- The container should run on port `8000`.
- The deployment should pass useful runtime values so the app can show clear details in `/version`, `/status`, or `/`.
- The remote host should check `/health`, `/version`, and `/status`.
- The runner should also validate `/health`, `/version`, and `/status` after deploy.
- After the workflow succeeds, run this from your repository root:

```bash
bash scripts/assessment/validate-deployment.sh http://<vm-host>:8000
```

## Acceptance Criteria

- Opening or updating a pull request to `main` starts the CI part of the workflow.
- The visible CI quality gate runs tests, Ruff, Trivy filesystem scan, Trivy Dockerfile/config scan, and Trivy image scan.
- The `main` branch is configured to require that CI quality gate before merge.
- The logs show the exact image reference that was pushed.
- Merging to `main` starts the CD part of the workflow.
- The remote host runs the same image that the workflow pushed earlier.
- `/health`, `/version`, and `/status` all respond successfully.
- You can explain which part is CI, which part is CD, what exact image was deployed, and why this flow is repeatable.
