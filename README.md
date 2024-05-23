To build:

   docker build --build-arg="NPROC=8" --build-arg="TIMESTAMP=$(date)" -t linux-kernel-builder:6.8.9 .
