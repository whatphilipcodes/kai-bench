#!/bin/bash

MODEL="unsloth/Qwen3.8-27B-GGUF:Q4_1"

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
  --port 8000 \
  -ngl 99 \
  -b 4096 \
  -ub 4096 \
  --parallel 1 \
  --ctx-size 16384 \
  --flash-attn on \
  --threads 8 \
  --reasoning off