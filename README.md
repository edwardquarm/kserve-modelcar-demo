# KServe ModelCar Demo

This repository contains resources for deploying and managing the ModelCar demo using KServe.

# Load env variable

Before building the container image, load the required environment variables by sourcing the `env.sh` script:

```bash
source env.sh
```

Ensure that the `env.sh` script contains the necessary environment variables, such as `HF_AUTH_TOKEN`.

## Building the Container Image

To build the container image, use the following command:

```bash
podman build vllm-modelcar/ -t modelcar-gemma-3:latest --platform linux/amd64 --build-arg HF_AUTH_TOKEN=${HF_AUTH_TOKEN}
```

- Replace `${HF_AUTH_TOKEN}` with your Hugging Face authentication token.
- Ensure that `podman` is installed and configured on your system.

## Pushing the Container Image to Quay

After building the image, push it to Quay using the following command:

```bash
podman push modelcar-gemma-3:latest quay.io/<your-registry>/modelcar-gemma-3-4b-it:latest
```

- Ensure you are logged in to Quay before pushing the image.

## Notes

- The `HF_AUTH_TOKEN` is required for accessing private Hugging Face models or resources during the build process.
- The image is tagged as `modelcar-gemma-3:latest` locally and pushed to the Quay repository as `quay.io/<your-registry>/modelcar-gemma-3-4b-it:latest`.

