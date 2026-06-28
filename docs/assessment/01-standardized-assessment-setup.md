# Standardized Assessment Setup

## Purpose

This page explains the one setup model used for the final assessment.

## The Standard Target

Use one shared deployment target for the final assessment:

- one Ubuntu VM
- one SSH-based delivery path
- one simple validation path with `/health`, `/version`, and `/status`

## Standardized Delivery Model

For fairness, use one shared delivery model for the whole cohort.

The course standard is:

- run CI on pull requests to `main`
- require that CI before merge
- build a Docker image after merge
- push it to a container registry
- deploy it on a Linux host over SSH
- run it as a Docker container on that host

## Why Docker Is The Standard

This Docker setup balances simplicity and realism well:

- it stays close to the current packaging labs
- it keeps one exact image tag for traceability
- it is easy to validate from the browser and from workflow logs
- it does not depend on one specific cloud provider

## What Makes It Beginner-Friendly

The setup still avoids heavy infrastructure:

- no Kubernetes
- no cloud orchestration
- no managed registry administration
- no complex platform networking

## Exact Thing You Deploy

You should always be able to answer:

"What exact thing did I deploy?"

In this assessment, the answer is one clear Docker image tag:

`YYYY-MM-DD-GITHUB_RUN_ID`

That same tagged image is:

- built in GitHub Actions
- pushed to the registry
- pulled onto the remote Linux host
- started as the deployed container

## Registry Shape

For this course, keep the registry side simple:

- use one registry host value
- use one image name: `tiny-health-app`
- use one credential set supplied for the assessment

Your instructor will tell you what registry service is used in your cohort.

## What Stays the Same in the Assessment

The assessment still measures the same course story:

- verify first
- keep merge gated by CI
- deliver a known output
- validate the running app
- explain what was deployed

## Backup Path

If the Docker registry path is temporarily unreliable during teaching, the instructor can fall back to this recovery shape:

- copy the built image tar file to the same VM
- load it with Docker on the VM
- run the same container there

That keeps the same Docker deployment target and the same validation path.

It is a recovery path, not the main assessment model.
