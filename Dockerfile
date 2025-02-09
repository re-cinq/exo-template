FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04
LABEL com.nvidia.volumes.needed=nvidia_driver
RUN apt -y update && apt -y install python3 python3-pip
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade torch torchao torchvision
RUN python3 -m pip install --upgrade torchtune

ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CMD ["/usr/local/bin/tune"]
