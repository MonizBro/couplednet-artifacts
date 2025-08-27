#!/bin/bash
#SBATCH --job-name=MyJob                         # Job name
#SBATCH --partition=dgx                          # Target partition/queue
#SBATCH --gres=gpu:8                             # Request GPUs (e.g., 8 GPUs)
#SBATCH --cpus-per-task=16                       # Request CPUs per task
#SBATCH --time=7-00:00:00                        # Time limit (D-HH:MM:SS)
#SBATCH --output=./logs/output.%j.out            # STDOUT log (%j = job ID)
#SBATCH --error=./logs/error.%j.err              # STDERR log

#SBATCH --exclude=node01,node02                  # Exclude specific nodes

# ------------------------------
# Environment Setup
# ------------------------------

# Load Conda initialization
source /path/to/miniconda/etc/profile.d/conda.sh

# Activate the environment
conda activate /path/to/conda_env

# ------------------------------
# Launch Jupyter Lab
# ------------------------------

jupyter lab \
  --allow-root \
  --port=8888 \
  --no-browser \
  --ip=0.0.0.0 \
  --ServerApp.token='' \              # leave blank or set your own token
  --ServerApp.allow_origin='*' \
  --notebook-dir=/path/to/notebooks \
  1> >(tee -a /dev/stdout) \
  2> >(tee -a /dev/stderr >&2)
