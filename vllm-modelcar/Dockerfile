FROM registry.access.redhat.com/ubi9/python-311:latest as base

USER root

RUN pip install huggingface-hub

ARG HF_AUTH_TOKEN
ENV HF_AUTH_TOKEN=${HF_AUTH_TOKEN}


# Download the model file from hugging face
COPY download_model.py .

RUN python download_model.py 

# Final image containing only the essential model files
FROM registry.access.redhat.com/ubi9/ubi-micro:9.4

# Copy the model files from the base container
COPY --from=base /models /models

USER 1001