FROM nvidia/cuda:11.4.3-runtime-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3.9-venv \
    python3.9-dev \
    python3-pip \
    wget \
    git \
    && rm -rf /var/lib/apt/lists/*

# Make python3.9 the default
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Upgrade pip
RUN python -m pip install --upgrade pip

# Install PyTorch 1.10.0 (with CUDA 11.3 wheel, compatible with CUDA 11.4 runtime)
RUN pip install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 \
    -f https://download.pytorch.org/whl/torch_stable.html
COPY DiffAct/requirements.txt /workspace/DiffAct/requirements.txt
WORKDIR /workspace
RUN pip install -r DiffAct/requirements.txt

# Set working directory
WORKDIR /workspace

CMD ["/bin/bash"]
