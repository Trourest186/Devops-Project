For CI/CD purposes, I've designed two repositories, each catering to software production with two branches.

## Container Image Repository:

- Repository 1 is dedicated to storing container images in a container registry.
- It consists of two branches:
  - dev branch serves for simple development, employing CI to build images with the latest tag.
  - product branch is for production, utilizing CI to build images with specific tags.
## Helm Chart Repository:

- Repository 2 is intended for storing Helm charts in a package registry.
- It also has two branches corresponding to the workflow:
  - dev branch is used for continuous development, with CI managing the Helm chart packaging process.
  - product branch facilitates continuous deployment in the cluster, allowing for CD workflows.

This setup enables a streamlined CI/CD pipeline, managing container images and Helm charts separately for development and production environments.
