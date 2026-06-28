# How the Current Labs Prepare You

## Purpose

This page shows how the existing labs and exercises already prepare you for the final assessment.

## Readiness Map

| Existing item | What it teaches | Why it matters for the final assessment |
|---|---|---|
| `LAB-02: Real CI Workflow` | verification with tests | the assessment workflow still starts by proving the change is safe |
| `EX-05: CI Quality and Security Checks` | linting and scan visibility in CI | the assessment CI gate now includes Ruff and Trivy checks before merge |
| `EX-06: Build Artifact with Buildx` | reusable container build actions | the assessment workflow can reuse the same clearer build action shape |
| `EX-07: Build Artifact Scan with Trivy` | image scan thinking for packaged output | the assessment CI path also scans a built image before merge |
| `LAB-03: Build Artifact Workflow` | packaging and saved deployable output | the assessment workflow still prepares one clear deployable package |
| `LAB-04: Deploy Workflow` | deliver the built package and smoke-test it | the assessment workflow still deploys and checks the running app |
| `EX-09: Deploy and Inspect the Deployment` | inspect a running deployment more carefully | the assessment still asks you to prove what is running after deploy |
| `LAB-05: Full CI/CD Flow` | end-to-end reasoning across multiple workflows | the final assessment still asks you to explain the full story, not just one command |
| `EX-11: PR-Based CI/CD with Branch Protection` | PR gating and required checks | it prepares the final assessment trigger model and the merge rule |
| `LAB-06: Full Containerized CI/CD Pipeline` | one fuller verify-build-deploy workflow | this optional lab is the closest preview of the assessment workflow shape |

## What the Final Assessment Adds

The final assessment adds only a few new ideas:

- split PR CI and post-merge CD into two realistic workflows
- push the image to a registry
- use SSH to reach a real Ubuntu VM
- pull the exact image on that VM
- prove what was deployed with `/health`, `/version`, and `/status`

The one new GitHub Actions pattern to notice is this:

- pass the exact image tag and image reference from the build job to the deploy job with outputs

That pattern appears later because the assessment is the first place where build and deploy truly need a computed per-run image value.

## How the Earlier Labs Support the Assessment

These ideas stay useful in the final assessment:

- `LAB-02` still prepares verification first
- `LAB-04` still prepares delivery and validation thinking
- `LAB-05` still prepares end-to-end reasoning
- `EX-11` still prepares the idea that trusted delivery follows a trusted path

The assessment is prepared directly by the current labs because `LAB-03`, `LAB-04`, and `EX-06` already use image packaging ideas.

## Main Lesson

The final assessment is not a new story.

It is the same story with one more realistic delivery target:

`code -> verify -> package -> deliver`

## If You Need a Quick Review

If one part of the final assessment feels shaky, go back to the matching earlier lab:

- review `LAB-02` if verification steps or test runs still feel fuzzy
- review `LAB-03` if image tags or packaged output still feel fuzzy
- review `LAB-04` if deploy steps or smoke tests still feel fuzzy
- review `LAB-05` if the full story still feels broken into separate pieces
