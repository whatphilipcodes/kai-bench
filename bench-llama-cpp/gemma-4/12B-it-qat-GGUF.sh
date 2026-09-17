#!/bin/bash
# run-server.sh

MODEL="unsloth/gemma-4-12B-it-qat-GGUF"

/home/philip/repos/llama.cpp/build/bin/llama-server \
  -hf $MODEL \
  --port 8000  \
  --parallel 1 \
  --gpu-layers auto \
  --hf-repo-draft $MODEL \
  --spec-type draft-mtp \
  --spec-draft-n-max 4 \
  --ctx-size 16384 \
  --flash-attn on \
  --reasoning off
