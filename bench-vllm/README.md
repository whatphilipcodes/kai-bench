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
