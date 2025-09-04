#!/usr/bin/bash

set -e

# Change to parent directory
cd ..

# Build the Docker image
echo "Building bag_converter Docker image..."

# Build the image from parent directory
docker build -t bag_converter:latest -f docker/Dockerfile .

echo "Docker image built successfully: bag_converter:latest"
