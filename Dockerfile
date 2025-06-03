FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Install build tools, wget, and git
RUN apt-get update && apt-get install -y apt-utils wget git gcc g++ make cmake

# Install Miniconda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh && \
    /opt/conda/bin/conda clean -afy

ENV PATH="/opt/conda/bin:$PATH"
ENV CUDA_HOME=/usr/local/cuda
ENV LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
ENV TCNN_CUDA_ARCHITECTURES=86

COPY sdf/env.sh /opt/sdf_env.sh
COPY splat/env.sh /opt/splat_env.sh
COPY isaac_sim/env.sh /opt/isaac_sim_env.sh
COPY sdf /home/sabin.grube@local.eurecat.org/DRAWER/sdf
COPY splat /home/sabin.grube@local.eurecat.org/DRAWER/splat
COPY isaac_sim /home/sabin.grube@local.eurecat.org/DRAWER/isaac_sim

WORKDIR /home/sabin.grube@local.eurecat.org/DRAWER/sdf
RUN bash -c "source /opt/sdf_env.sh"
WORKDIR /home/sabin.grube@local.eurecat.org/DRAWER/splat
RUN bash -c "source /opt/splat_env.sh"
WORKDIR /home/sabin.grube@local.eurecat.org/DRAWER/isaac_sim
RUN bash -c "source /opt/isaac_sim_env.sh"
WORKDIR /home/sabin.grube@local.eurecat.org/DRAWER

CMD ["bash"]