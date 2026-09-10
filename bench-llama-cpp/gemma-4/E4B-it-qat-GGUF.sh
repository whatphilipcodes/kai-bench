#!/bin/bash

MODEL="unsloth/gemma-4-E4B-it-qat-GGUF:Q4_K_XL"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$SCRIPT_DIR/../../.env"

if [ -f "$ENV_PATH" ]; then
  set -a
  source "$ENV_PATH"
  set +a
fi

export GGML_CUDA_FORCE_MMQ=1

/home/philip/repos/llama.cpp/build/bin/llama-server \
  -hf "$MODEL" \
  --no-mmproj \
  --port 8000 \
  -ngl 99 \
  -b 2048 \
  -ub 2048 \
  --parallel 1 \
  --ctx-size 8192 \
  --flash-attn on \
  --threads 16 \
  --no-warmup \
  --reasoning off