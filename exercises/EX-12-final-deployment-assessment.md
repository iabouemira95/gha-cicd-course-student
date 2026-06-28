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

## Workflows To Create

- `.github/workflows/08-final-assessment-ci.yml`
- `.github/workflows/09-final-assessment-cd.yml`

Start from these guided starters:

- `docs/assessment/starter-workflows/08-final-assessment-ci-starter.yml`
- `docs/assessment/starter-workflows/09-final-assessment-cd-starter.yml`

This is the later exception where you create new workflow files.

These new files are still derived from earlier lab workflows:

- take the verify idea from `.github/workflows/02-ci.yml`
- take the packaging idea from `.github/workflows/03-build-artifact.yml`
- take the delivery-and-validation idea from `.github/workflows/04-deploy.yml`

Copy the two starters into `.github/workflows/08-final-assessment-ci.yml` and `.github/workflows/09-final-assessment-cd.yml`, then fill the gaps yourself.

## Important Concepts Before You Build

Keep these ideas clear before you start editing:

- `08-final-assessment-ci.yml` answers: "Is this change safe enough to merge?"
- `09-final-assessment-cd.yml` answers: "Now that trusted code reached `main`, can we package and deliver it?"
- branch protection uses the visible CI job result to block merge until verification passes
- the CD workflow uses one exact image tag and one exact image reference so build and deploy talk about the same thing

### One Small GitHub Actions Pattern You Will Use

Inside the CD workflow, the deploy job needs the same image values created in the build job.

That is why the starter uses:

- step outputs written through `GITHUB_OUTPUT`
- job outputs exposed from the build job
- `needs.build-and-push.outputs...` inside the deploy job

This is not "advanced for the sake of advanced."

It is the smallest clean way to pass one exact image tag and one exact image reference from build to deploy inside one workflow.

### What To Avoid In This Assessment

Do not add extra GitHub Actions features unless your instructor explicitly asks for them.

Avoid:

- `fail-fast`
- `always()`
- reusable workflows
- matrix builds in the assessment workflows
- extra helper jobs that do not support the story directly

The goal is a clear, teachable path, not the most clever YAML.

## Requirements

- The CI workflow should trigger on pull requests to `main`.
- The CD workflow should trigger only after trusted code reaches `main`.
- The PR CI job should use one stable visible job name such as `CI quality gate`.
- The PR CI job should run the project tests before packaging or deployment.
- The PR CI job should include Ruff linting.
- The PR CI job should include a Trivy filesystem scan.
- The PR CI job should include a Trivy Dockerfile/config scan.
- The PR CI job should build one local image only for scan visibility and run a Trivy image scan against it.
- The `main` branch should require the PR CI job as a status check before merge.
- The CD workflow should build the image from the current `Dockerfile`.
- The CD workflow should push the image to the container registry your instructor provides.
- The CD workflow logs should show the full image reference clearly.
- The CD workflow should pass the exact image tag and image reference from the build job to the deploy job clearly.
- The CD workflow should connect to the Linux host over SSH using GitHub secrets.
- The deployment target should be one SSH-reachable Linux host such as an Ubuntu VM.
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

- Opening or updating a pull request to `main` starts the CI workflow.
- The visible CI quality gate runs tests, Ruff, Trivy filesystem scan, Trivy Dockerfile/config scan, and Trivy image scan.
- The `main` branch is configured to require that CI quality gate before merge.
- The CD workflow logs show the exact image reference that was pushed.
- Merging to `main` starts the CD workflow.
- The remote host runs the same image that the workflow pushed earlier.
- `/health`, `/version`, and `/status` all respond successfully.
- You can explain which workflow is CI, which workflow is CD, what exact image was deployed, and why this flow is repeatable.
