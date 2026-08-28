#!/bin/bash
# run-server.sh

MODEL="ggml-org/gemma-4-E4B-it-GGUF:Q8_0"

/home/philip/repos/llama.cpp/build/bin/llama-server \
  -hf $MODEL \
  --port 30000  \
  --parallel 1 \
  --gpu-layers auto \
  --hf-repo-draft $MODEL \
  --spec-type draft-mtp \
  --spec-draft-n-max 4 \
  --ctx-size 16384 \
  --flash-attn on \
  --chat-template-kwargs "{\"enable_thinking\":false}"
