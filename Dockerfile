# Use an official Debian base image
FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    fakeroot \
    libncurses5-dev \
    libssl-dev \
    ccache \
    bison \
    flex \
    libelf-dev \
    bc \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to where we will download and extract the kernel
WORKDIR /usr/src

# Download and extract the specific Linux kernel version
RUN wget https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.8.9.tar.xz \
    && tar -xvf linux-6.8.9.tar.xz \
    && rm linux-6.8.9.tar.xz

# Change to the extracted directory
WORKDIR /usr/src/linux-6.8.9

# Use default configuration for x86_64 architecture
RUN make defconfig

ARG NPROC
ARG TIMESTAMP

# Invalidate layers from here on
RUN echo "$TIMESTAMP" >/tmp/timestamp.tmp

# Compile the kernel with default settings
RUN make -j$NPROC

# Set the default command
CMD ["bash"]
