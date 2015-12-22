#!/bin/bash -e

# Bring to latest state
sudo apt-get update && sudo apt-get -y upgrade

# Install dependencies
sudo apt-get install -y git libgmp-dev libmpfr-dev libmpc-dev zlib1g-dev \
 texinfo build-essential flex bison
