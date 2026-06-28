# GitHub Actions CI/CD Course for Beginners

## What This Repository Is For

This is the student repository for a 2-day beginner-friendly CI/CD course.

We will follow one simple story through the whole course:

1. code
2. verify
3. package
4. deliver

## Start Here

Use these four entry points to navigate the repository:

1. [Student Setup Guide](docs/setup/README.md)
2. [Labs Guide](labs/README.md)
3. [Exercises Index](exercises/README.md)
4. [Help Guide](docs/help/README.md)

## How to Use This Repository During Class

- Open the section for the part of the course we are in now.
- Early labs are browser-first. You do not need local Git to start.
- Change one thing at a time, especially in YAML files.
- If a workflow fails, read the logs before changing more files.

## Core versus Optional

During the main course, focus on Labs `01` to `05`.

For the core path, focus on these workflows:

- `01 Hello Workflow`
- `02 CI Workflow`
- `03 Build Artifact Workflow`
- `04 Deploy Workflow`

At the start of the course, focus on the four core workflows first.

Use this simple rule:

- core beginner path = workflows `01` to `04` and Labs `01` to `05`
- `LAB-05` is still part of the guided Day 2 continuation
- `LAB-05` does not correspond to workflow `05`
- later guided extension = `LAB-07` and `EX-12` when your instructor starts the Ubuntu VM assessment path
- optional examples = workflow examples `05`, `06`, `LAB-06`, and the cloud-oriented extra reading
- most exercises modify the workflow file from the lab you just finished
- `EX-12` is the later exception where you create workflows `08` and `09`

Use this quick rule in the `Actions` tab:

- main path = the lab or exercise page your instructor is teaching now
- core workflows = `01`, `02`, `03`, `04`
- most exercises = keep modifying the lab workflow file you already know
- final assessment prep workflow = `07`
- final assessment workflow = create `08` yourself later when the final assessment page asks you to
- optional next-step examples = workflows `05`, `06`, and later example pages

Workflows `08` and `09` will not appear in the `Actions` tab until you create `.github/workflows/08-final-assessment-ci.yml` and `.github/workflows/09-final-assessment-cd.yml` during `EX-12`.

## Before Class

Use these files first:

1. [Setup Guide](docs/setup/README.md)
2. [Git and GitHub Micro Prerequisites](docs/setup/00-git-and-github-micro-prerequisites.md)
3. [Create a GitHub Account](docs/setup/01-create-github-account.md)
4. [Create Your Course Repository from the Template](docs/setup/02-create-your-course-repo-from-template.md)
5. [Find the Actions Tab and Check Workflows](docs/setup/03-find-the-actions-tab-and-check-workflows.md)

## Day 1

Day 1 is about one question:

How do we know a change is still safe?

Open these files during Day 1:

1. [Course Story with Diagrams](docs/course-story/README.md)
2. [Course Map](docs/00-course-map.md)
3. [Engineering Problems, CI/CD, and Branching Strategy](docs/09-engineering-problems-cicd-and-branching.md)
4. [GitHub Actions Foundations](docs/10-github-actions-foundations.md)
5. [Lab 01: First Workflow](labs/LAB-01-first-workflow.md)
6. [Exercise 01: Hello Trigger and PR Merge](exercises/EX-01-hello-trigger-and-pr-merge.md)
7. [How to Read Actions Logs](docs/help/01-how-to-read-actions-logs.md)
8. [Lab 02: Real CI Workflow](labs/LAB-02-real-ci-workflow.md)
9. [Exercise 02: CI Visibility and Schedule](exercises/EX-02-ci-visibility-and-schedule.md)
10. [Exercise 03: CI Matrix Across OS and Python](exercises/EX-03-ci-matrix.md)
11. [Exercise 04: CI Secrets as Environment Variables](exercises/EX-04-ci-secrets-and-matrix.md)
12. [Exercise 05: CI Quality and Security Checks](exercises/EX-05-ci-quality-and-security-checks.md)
13. [Exercises Index](exercises/README.md)
14. [Labs Guide](labs/README.md)

Exercises always follow the related lab.

Use these supporting pages only when you need them:

1. [Course Map](docs/00-course-map.md)
2. [Our Tiny Example App](docs/01-our-tiny-example-app.md)
3. [Runner Mental Model](docs/help/00-runner-mental-model.md)
4. [Trigger Reference](docs/help/06-trigger-reference.md)
5. [YAML Cheatsheet for GitHub Actions](docs/help/04-yaml-cheatsheet.md)
6. [Finding and Reusing GitHub Actions](docs/help/07-finding-and-reusing-actions.md)

## Day 2

Day 2 is about one question:

What do we deliver after the code is verified?

Open these files during Day 2:

1. [Day 2 Opening Bridge](docs/day-2-opening-bridge.md)
2. [Artifacts, Images, and Containers](docs/02-artifacts-images-and-containers.md)
3. [Lab 03: Build Artifact Workflow](labs/LAB-03-build-artifact-workflow.md)
4. [Exercise 06: Build Artifact with Buildx](exercises/EX-06-build-artifact-with-buildx.md)
5. [Exercise 07: Build Artifact Scan with Trivy](exercises/EX-07-build-artifact-scan-with-trivy.md)
6. [Exercise 08: CI Then Build Artifact With `needs`](exercises/EX-08-ci-then-build-artifact-with-needs.md)
7. [Simulated Deployment](docs/03-simulated-deployment.md)
8. [Lab 04: Deploy Workflow](labs/LAB-04-deploy-workflow.md)
9. [Exercise 09: Deploy and Inspect the Deployment](exercises/EX-09-deploy-inspect-the-deployment.md)
10. [Lab 05: Full CI/CD Flow](labs/LAB-05-full-cicd-flow.md)
11. [Exercise 10: Full Flow Failure and Recovery](exercises/EX-10-full-flow-failure-and-recovery.md)
12. [Exercise 11: PR-Based CI/CD with Branch Protection](exercises/EX-11-pr-based-ci-cd-with-branch-protection.md)
13. [Final Recap](docs/04-final-recap.md)
14. [Labs Guide](labs/README.md)

`EX-06`, `EX-07`, and `EX-08` all extend `.github/workflows/03-build-artifact.yml`.

Do `EX-06` first, then use `EX-07` to add an artifact scan, and `EX-08` to strengthen that same build workflow with a clearer multi-job shape.

`LAB-05` is the integration lab that reuses workflows `02`, `03`, and `04`.

## Final Assessment

After the main Day 2 path and the related exercises, your instructor may give you one final assessed exercise.

It keeps the same story and asks you to build one fuller deployment workflow yourself:

- run CI on pull requests to `main`
- require that CI before merge
- after merge, build and push one image
- deploy that same image to one SSH-reachable Linux host

The only important new GitHub Actions pattern here is passing one exact image value from the build job to the deploy job.

That pattern is introduced inside `EX-12` on purpose.

Open these files in order:

1. [Final Assessment Support Overview](docs/assessment/README.md)
2. [Standardized Assessment Setup](docs/assessment/01-standardized-assessment-setup.md)
3. [Prepare the Assessment VM](docs/setup/04-prepare-assessment-vm.md)
4. [Prepare the Ubuntu VM](docs/assessment/02-prepare-ubuntu-vm.md)
5. [Configure Registry, SSH, and GitHub Secrets](docs/assessment/03-configure-secrets-and-ssh.md)
6. [How the Current Labs Prepare You](docs/assessment/04-how-current-labs-prepare-you.md)
7. [LAB-07: Final Assessment Setup and Validation Prep](labs/LAB-07-docker-hub-vm-deploy.md)
8. [Assessment Success Criteria, Validation, and Rubric](docs/assessment/05-success-criteria-and-rubric.md)
9. [EX-12: Final Deployment Assessment](exercises/EX-12-final-deployment-assessment.md)

`LAB-07` uses one preloaded readiness workflow to check the setup.

`EX-12` is the build-it-yourself part.

Start `EX-12` from the guided starters in:

- `docs/assessment/starter-workflows/08-final-assessment-ci-starter.yml`
- `docs/assessment/starter-workflows/09-final-assessment-cd-starter.yml`

You create the final assessment workflow files yourself, and the prepared solutions live only in the instructor repo.

Workflows `08` and `09` will not appear in the `Actions` tab until you create `.github/workflows/08-final-assessment-ci.yml` and `.github/workflows/09-final-assessment-cd.yml` during `EX-12`.

## Assessment Prep

Use this only when your instructor asks you to prepare the Ubuntu VM assessment path.

The early course flow stays browser-first.

You do not need the assessment VM setup script before Day 1 or the early labs.

The later assessment path does require a local shell because you will use commands such as `scp`, `ssh`, and the local validation helper.

If you do not already have the repository on your machine by then, get a local copy first before you start the VM setup steps.

When the assessment path starts, use:

- [Prepare the Assessment VM](docs/setup/04-prepare-assessment-vm.md)
- [scripts/install-assessment-deps.sh](scripts/install-assessment-deps.sh)

## Optional Next Steps

Use these after the main course if you want a little more context:

1. [CI vs CD](docs/05-ci-vs-cd.md)
2. [YAML Cheatsheet for GitHub Actions](docs/help/04-yaml-cheatsheet.md)
3. [Runner Types](docs/help/05-runner-types.md)
4. [Trigger Reference](docs/help/06-trigger-reference.md)
5. [Finding and Reusing GitHub Actions](docs/help/07-finding-and-reusing-actions.md)
6. [Next Steps: Matrix and Secrets](docs/06-next-steps-matrix-and-secrets.md)
7. [Full Containerized CI/CD Example](docs/07-full-containerized-cicd-example.md)
8. [How ACR and AKS Fit the Story](docs/08-how-acr-and-aks-fit-the-story.md)
9. [91 OPTIONAL Example - Azure ACR and AKS Workflow](.github/workflows/06-azure-acr-aks-example.yml)
10. [Lab 06: Full Containerized CI/CD Pipeline](labs/LAB-06-full-containerized-cicd-pipeline.md)

## If You Feel Stuck

Use these support files:

1. [Help Guide](docs/help/README.md)
2. [Runner Mental Model](docs/help/00-runner-mental-model.md)
3. [How to Read Actions Logs](docs/help/01-how-to-read-actions-logs.md)
4. [Troubleshooting](docs/help/02-troubleshooting.md)
5. [Glossary](docs/help/03-glossary.md)
6. [YAML Cheatsheet for GitHub Actions](docs/help/04-yaml-cheatsheet.md)

## One Reminder

You do not need to memorize GitHub Actions syntax.

Keep returning to the main story:

1. code
2. verify
3. package
4. deliver
