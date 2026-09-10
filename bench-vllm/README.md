# bench-vllm
```sh
uv run --env-file ../.env vllm serve --config <path>
```

### guides / info
https://unsloth.ai/docs/models/gemma-4#dgx-spark-with-nvfp4-quants


### via docker
interactive shell
```sh
docker run -it --gpus all --ipc=host --shm-size 96g \
  --entrypoint /bin/bash \
  -v /opt/huggingface_cache/hub:/root/.cache/huggingface/hub \
  -p 30000:30000 \
  vllm/vllm-openai:gemma4-unified
```

serve command
```sh
vllm serve RedHatAI/gemma-4-12B-it-NVFP4 \
  --kv-cache-dtype fp8 \
  --tensor-parallel-size 1 \
  --max-num-batched-tokens 8192 \
  --gpu-memory-utilization 0.4 \
  --max-model-len auto \
  --max-num-seqs 256 \
  --speculative-config '{"model":"google/gemma-4-12B-it-assistant","num_speculative_tokens":4}'
```

### The New Rise
docker run -it --gpus all --ipc=host --shm-size 8g --memory 80g \
  --entrypoint /bin/bash \
  -v /opt/huggingface_cache/hub:/root/.cache/huggingface/hub \
  -p 30000:30000 \
  vllm/vllm-omni:nightly-aarch64


vllm serve unsloth/gemma-4-12b-it-NVFP4 --omni --port 30000


uv run vllm serve unsloth/gemma-4-12b-it-NVFP4 \
  --quantization nvfp4 \
  --kv-cache-dtype nvfp4 \
  --linear-backend b12x \
  --speculative-config '{"model":"unsloth/gemma-4-12b-it-NVFP4","num_speculative_tokens":4, "speculative-decoding-mode":"dflash2"}'

uv run vllm serve unsloth/gemma-4-12b-it-NVFP4 \
  --kv-cache-dtype nvfp4 \
  --linear-backend b12x \
  --speculative-config '{"model":"unsloth/gemma-4-12b-it-NVFP4","num_speculative_tokens":4}'

uv run vllm serve unsloth/gemma-4-12b-it-NVFP4 \
  --hf-overrides '{"quant_method": "nvfp4"}' \
  --kv-cache-dtype nvfp4 \
  --linear-backend b12x


ValueError: Failed to find a kernel that can implement the ScaledMM linear layer. Reasons:
B12xTensorFP8ScaledMMLinearKernel requires static per-tensor activation scales.


uv run vllm serve nvidia/Qwen3.6-35B-A3B-NVFP4 --host 0.0.0.0 --port 8000 \
  --tensor-parallel-size 1 \
  --trust-remote-code \
  --kv-cache-dtype fp8 \
  --attention-backend flashinfer \
  --moe-backend marlin \
  --gpu-memory-utilization 0.72 \
  --max-model-len auto \
  --max-num-seqs 2 \
  --max-num-batched-tokens 2 \
  --enable-chunked-prefill \
  --async-scheduling \
  --enable-prefix-caching \
  --speculative-config '{"method":"mtp","num_speculative_tokens":3,"moe_backend":"triton"}' \
  --load-format fastsafetensors \
  --reasoning-parser qwen3 \
  --tool-call-parser qwen3_xml \
  --enable-auto-tool-choice