FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-runtime
LABEL com.nvidia.volumes.needed=nvidia_driver
COPY . /workspace/torchtune
RUN python -m pip install -e ".[optional-dependencies]"

ENTRYPOINT ["/bin/bash"]
ARG PYTORCH_VERSION=2.5.1
ARG TRITON_VERSION=
ARG TARGETPLATFORM=linux/amd64
ARG CUDA_VERSION=12.4.1
COPY /opt/conda /opt/conda # buildkit
RUN |4 PYTORCH_VERSION=2.5.1 TRITON_VERSION= TARGETPLATFORM=linux/amd64
ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTORCH_VERSION=2.5.1
WORKDIR /workspace
WORKDIR /app
COPY ml/requirements/fine_tuning.txt requirements.txt # buildkit
RUN /bin/sh -c pip install
