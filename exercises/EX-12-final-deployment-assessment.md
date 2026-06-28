# EX-12: Final Deployment Assessment

## Use This After

- [LAB-05: Full CI/CD Flow](../labs/LAB-05-full-cicd-flow.md)
- [EX-11: PR-Based CI/CD with Branch Protection](EX-11-pr-based-ci-cd-with-branch-protection.md)
- [LAB-07: Final Assessment Setup and Validation Prep](../labs/LAB-07-docker-hub-vm-deploy.md)

## Goal

Build one final deployment workflow that proves you can carry the course story into a more realistic target:

- verify the code
- prepare one exact deployable output
- deploy it to one Ubuntu VM over SSH
- validate what is running

This final exercise builds on `LAB-05`, `EX-11`, and `LAB-07`.

## Workflow To Create

- `.github/workflows/08-final-deployment-assessment.yml`

This is the later exception where you create a new workflow file.

That new file is still derived from earlier lab workflows:

- take the verify idea from `.github/workflows/02-ci.yml`
- take the packaging idea from `.github/workflows/03-build-artifact.yml`
- take the delivery-and-validation idea from `.github/workflows/04-deploy.yml`

## Requirements

- The workflow should use `workflow_dispatch`.
- The workflow should separate the work into clear jobs such as `verify`, `prepare-output`, and `deploy-to-vm`.
- The later jobs should depend on the earlier ones clearly.
- The workflow should run the project tests before packaging or deployment.
- The workflow should build the image from the current `Dockerfile`.
- The workflow should push the image to your public Docker Hub repository `tiny-health-app`.
- The workflow logs should show the full image reference clearly.
- The workflow should connect to the Ubuntu VM over SSH using GitHub secrets.
- The VM should pull the same image that was pushed earlier.
- The workflow should replace any older container safely.
- The container should run on port `8000`.
- The deployment should pass useful runtime values so the app can show clear details in `/version`, `/status`, or `/`.
- The workflow should check `/health`, `/version`, and `/status`.
- After the workflow succeeds, run this from your repository root:

```bash
bash scripts/assessment/validate-deployment.sh http://<vm-host>:8000
```

## Acceptance Criteria

- The `verify` part passes before the image is built or deployed.
- The logs show the exact image reference that was pushed.
- The VM runs the same image that the workflow pushed earlier.
- `/health`, `/version`, and `/status` all respond successfully.
- You can explain what exact thing was deployed and why this flow is repeatable.
