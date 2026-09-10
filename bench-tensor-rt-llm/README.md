env -u DISPLAY HWLOC_COMPONENTS=-gl uv run trtllm-serve unsloth/gemma-4-12b-it-NVFP4


# Prerequisites
sudo apt-get install openmpi-bin libopenmpi-dev


# Docker
```sh
docker pull nvcr.io/nvidia/tensorrt-llm/release:1.3.0rc26.dev202609010000
```
```sh
docker run --rm -it --gpus all --ipc=host --shm-size 96g \
  --ulimit memlock=-1 --ulimit stack=67108864 \
  -v /opt/huggingface_cache/hub:/root/.cache/huggingface/hub \
  -p 8000:8000 \
  nvcr.io/nvidia/tensorrt-llm/release:1.3.0rc26.dev202609010000 \
  /bin/bash
```
```sh
trtllm-serve unsloth/gemma-4-12b-it-NVFP4
```



cat > gemma4_config.yaml <<EOF
attn_backend: flashinfer
EOF

trtllm-serve google/gemma-4-E4B-it \
  --extra_llm_api_options gemma4_config.yaml \
  --kv_cache_free_gpu_memory_fraction 0.5 \
  --host 127.0.0.1 \
  --port 8000