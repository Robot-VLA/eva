# Base image with CUDA 12.4.1, cuDNN, Ubuntu 22.04
FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# Install common utilities
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    ca-certificates \
    wget \
    pkg-config \
    software-properties-common \
    libglib2.0-0 libsm6 libxext6 libxrender1 ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# (Optional) CUDA envs; base image already sets these, but harmless to be explicit
ENV CUDA_HOME=/usr/local/cuda \
    LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH} \
    PATH=/usr/local/cuda/bin:${PATH}

# Create workspace folders
RUN mkdir -p /workspace/repos /workspace/datasets

WORKDIR /workspace

# Default command
CMD echo "[INFO] Container is ready." && \
    echo "[INFO] Code is mounted at /workspace/repos and datasets at /workspace/datasets." && \
    bash
