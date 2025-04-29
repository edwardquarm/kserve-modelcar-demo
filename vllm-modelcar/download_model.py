from huggingface_hub import snapshot_download
import os

# Specify the Hugging Face repository containing the model
model_repo = "google/gemma-3-4b-it"
snapshot_download(
    repo_id=model_repo,
    local_dir="/models",
    allow_patterns=["*.safetensors", "*.json", "*.txt"],
    use_auth_token=os.getenv("HF_AUTH_TOKEN"),
)