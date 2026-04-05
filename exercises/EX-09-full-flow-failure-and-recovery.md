# EX-09: Full Flow Failure and Recovery

## Problem Statement

This is a challenge based on `LAB-05`.

The full CI/CD lab already showed the happy path:

- code changes
- CI verifies the change
- build creates the package
- deploy uses that same package

Now imagine the team asks:

"What happens to the full story when verification fails?
And what happens after we fix the problem?"

That is the challenge.

## Related Core Lab

Use this after:

- [LAB-05: Full CI/CD Flow](../labs/LAB-05-full-cicd-flow.md)

Do not start with this exercise.

Finish `LAB-05` first, then use this challenge at the end of Day 2 as a final capstone check.

## Concepts It Reinforces

- the full `code -> verify -> package -> deliver` story
- why verification must happen first
- why later stages should not continue after failure
- how the system recovers after a fix

## Challenge Files

This challenge reuses the core course files:

- `app/app.py`
- `.github/workflows/02-ci.yml`
- `.github/workflows/03-build-artifact.yml`
- `.github/workflows/04-deploy.yml`

## What to Do

1. make one very small change in `app/app.py` that breaks the existing tests
2. commit the change and watch `02 CI Workflow` fail
3. confirm that the build and deploy story does not continue
4. fix the change
5. commit again and watch the full story recover

One safe example is to change the health payload from `ok` to another word, then change it back.

## What to Notice

Look for:

- where the story stops when verification fails
- that packaging does not create confidence when CI is already broken
- that delivery should not continue from a failed verification path
- how the same system becomes healthy again after the fix

## Success Check

You are done when you can explain:

- why the story must stop at `verify` when tests fail
- why build and deploy should not continue after a failed verification result
- what changed after the fix
- how this challenge proves the value of the full CI/CD path
