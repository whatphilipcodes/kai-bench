#!/bin/bash
# run-server.sh

MODEL="ggml-org/gemma-4-26B-A4B-it-GGUF:Q8_0"

/home/philip/repos/llama.cpp/build/bin/llama-server \
  -hf $MODEL \
  --parallel 1 \
  --gpu-layers all \
  --hf-repo-draft $MODEL \
  --spec-type draft-mtp \
  --spec-draft-n-max 8 \
  --ctx-size 32768 \
  --port 30000