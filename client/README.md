`cd` into config dir (`.yaml` file) and run
```sh
uv run aiperf profile --config <filename>
```

```sh
uv run llama-benchy \
  --base-url http://localhost:8000/v1 \
  --model unsloth/Qwen3.6-35B-A3B-NVFP4-Fast \
  --depth 0 4096 8192 16384 \
  --tg 128 \
  --concurrency 1 2 \
  --latency-mode generation \
  --enable-prefix-caching \
  --exact-tg
```

```sh
uv run llama-benchy \
  --base-url http://localhost:8000/v1 \
  --model google/gemma-4-E4B \
  --depth 0 4096 8192 16384 \
  --tg 128 \
  --concurrency 1 2 \
  --latency-mode generation \
  --enable-prefix-caching \
  --exact-tg
```