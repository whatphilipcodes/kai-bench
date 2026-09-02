# Prerequisites
`rust` (sglang was built from source)

# Run
```sh
uv run --env-file ../.env sglang serve \
  --model-path <model/name> \
  --config <path>
```

```sh
uv run --env-file ../.env sglang serve \
  --model-path google/gemma-4-E2B-it \
  --config gemma-4/E2B-it.yaml
```

# Docker
interactive shell
```sh
docker run -it --gpus all --ipc=host --shm-size 96g \
  -v /opt/huggingface_cache/hub:/root/.cache/huggingface/hub \
  -p 30000:30000 \
  lmsysorg/sglang:latest \
  /bin/bash
```

serve command
```sh
sglang serve --model-path google/gemma-4-12B-it \
  --speculative-algorithm NEXTN \
  --speculative-draft-model-path google/gemma-4-12B-it-assistant \
  --speculative-num-steps 5 \
  --speculative-num-draft-tokens 6 \
  --speculative-eagle-topk 1 \
  --mem-fraction-static 0.85 \
  --host 0.0.0.0 --port 30000
```