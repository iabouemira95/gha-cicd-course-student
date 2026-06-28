# LAB-03: Build Artifact Workflow

## Goal

Your goal is to see the application packaged as a build artifact.

## Why This Lab Matters

In the CI lab, we verified the code.

In this lab, we go one step further:

We package the application and keep the packaged output.

For this lab, you do not need to build Docker locally on your laptop.

GitHub Actions will do the build work for you.

## File for This Lab

Open this file in your repository:

`.github/workflows/03-build-artifact.yml`

## What This Workflow File Contains

This workflow keeps the CI check and adds packaging:

- `workflow_dispatch` lets you run it manually
- `Run tests` verifies the code before packaging
- `Build Docker image with docker build` creates one simple packaged image
- `Save Docker image as artifact file` turns the image into a saved file
- `Upload build artifact` stores that packaged file for later use

## Step 1: Read the Workflow File

Read the file once before running it.

You should be able to find:

- the test step
- the Docker build step
- the artifact upload step

## Step 2: Read the Main Docker Command

The core packaging command in this lab is:

```bash
docker build -t "tiny-health-app:course" .
```

What this means:

- `docker build` builds an image from the `Dockerfile`
- `-t` gives the image one simple fixed course name
- `.` means "build using the current folder"

For this core lab, the point is packaging itself.

We keep the image name simple so you do not have to think about dynamic tag generation yet.

## How the Docker Image Tar File Can Be Used

When the workflow saves the built image as a `.tar` file, it is turning the packaged image into a normal file we can carry forward.

For this course, that tar file can be used in simple ways:

- uploaded as a GitHub Actions artifact
- downloaded by a later workflow
- loaded back into Docker with `docker load`
- used as the exact built package for deployment steps

That is why the tar file matters.

It helps us say:

"Use the image we already built" instead of "build it again and hope it matches."

## Step 3: Run the Workflow Manually

Open the `Actions` tab.

Open `03 Build Artifact Workflow`.

Use `Run workflow` to start the workflow manually.

## Step 4: Open the Workflow Run

Open the new run and watch the steps.

You should see steps like:

- `Check out repository`
- `Set up Python`
- `Run tests`
- `Build Docker image with docker build`
- `Save Docker image as artifact file`
- `Upload build artifact`

## Step 5: Find the Artifact

On the workflow run page, look for the artifact section.

You should see an artifact named:

`tiny-health-app-image`

You do not need to inspect the file contents for this lab.

The important point is that the workflow produced a packaged output and saved:

- the image file itself as a reusable workflow artifact

## Step 6: Explain the Story in Your Own Words

Try to describe the workflow like this:

1. the workflow checks the app
2. the workflow builds the package
3. the workflow saves the package for later use

## What You Should Notice

This workflow is important because it creates a reusable output.

That output can be used later in deployment instead of rebuilding from scratch again.

You should also notice that tests still run here.

That is intentional:

before packaging, we still keep one quick safety check inside the same workflow.

## If the Workflow Fails

Check these things first:

1. open the failed step
2. see whether the failure happened in tests or in the Docker build
3. read the first clear error message
4. compare your files with the course example

If the Docker step fails, ask your instructor for help before changing many lines.

## Success Check

You are done when:

- the workflow passes
- you can see the artifact name on the run page
- you can explain the difference between code and artifact

## Reflection

After the lab, try to answer these questions:

- Why is a build artifact useful?
- Why is an image different from a container?
- Why is saving the packaged output better than relying only on source code?
- How is the Buildx version of this workflow similar to the plain `docker build` version?

## Exercises After Lab 03

After this lab, continue with:

- [EX-06: Build Artifact with Buildx](../exercises/EX-06-build-artifact-with-buildx.md)
- [EX-07: Build Artifact Scan with Trivy](../exercises/EX-07-build-artifact-scan-with-trivy.md)
- [EX-08: CI Then Build Artifact With `needs`](../exercises/EX-08-ci-then-build-artifact-with-needs.md)

All three exercises still extend `.github/workflows/03-build-artifact.yml`.

Each one can start from the clean `LAB-03` workflow if you want a safe reset.

## Assessment Preparation Link

Later, the final assessment uses the same packaging ideas again:

- one built image
- one saved package
- one deployable output carried forward

In the final assessment, you will add more traceability around image tags because the image is pushed to a registry and reused on a real VM.

If you want to see how this lab prepares you for that track, use:

- [How the Current Labs Prepare You](../docs/assessment/04-how-current-labs-prepare-you.md)
