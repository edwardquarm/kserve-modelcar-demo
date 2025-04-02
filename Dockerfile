# Base image for downloading the model
FROM registry.access.redhat.com/ubi9/python-311:latest as base

USER root

# add dir model-store


# Copy the requirements file
COPY requirements.txt requirements.txt

# Install the requirements
RUN pip install -r requirements.txt

# Copy the files
COPY . .
COPY config/config.properties /config/config.properties

# Download the transformer model and tokenizer
RUN python Download_Transformer_models.py


# Create .mar file
RUN mkdir -p /model-store && torch-model-archiver \
    --model-name DISTLBERTClassifier \
    --version 1.0 \
    --serialized-file Transformer_model/model.safetensors \
    --handler Transformer_handler_generalized.py \
    --config-file model-config.yaml \
    --extra-files "Transformer_model/config.json,text_classification_artifacts/index_to_name.json" \
    --export-path /model-store

# Final image containing only the essential model files
FROM registry.access.redhat.com/ubi9/ubi-micro:9.4

# Copy the model archive from the base image
COPY --from=base /model-store/DISTLBERTClassifier.mar /model-store/
COPY --from=base /config/config.properties /config/config.properties

USER 1001