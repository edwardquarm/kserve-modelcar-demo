# Base image for downloading the model
FROM registry.access.redhat.com/ubi9/python-311:latest as base

USER root

RUN mkdir /models && chmod 777 /models

# Copy the files
COPY . .
COPY config.properties /models


# Install the requirements
RUN pip install -r requirements.txt


# Download the transformer model and tokenizer
RUN python Download_Transformer_models.py


# Create .mar file
RUN mkdir -p /models/model-store && torch-model-archiver \
    --model-name DISTLBERTClassifier \
    --version 1.0 \
    --serialized-file Transformer_model/model.safetensors \
    --handler Transformer_handler_generalized.py \
    --config-file model-config.yaml \
    --extra-files "Transformer_model/config.json,text_classification_artifacts/index_to_name.json" \
    --export-path /models/model-store

# Final image containing only the essential model files
FROM registry.access.redhat.com/ubi9/ubi-micro:9.4

RUN mkdir /models && chmod 777 /models

# Copy the model archive from the base image
COPY --from=base /models /models

# Set the user to non-root
USER 1001