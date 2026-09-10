# kai-bench module

```sh
docker compose -f <file>.yaml up
```

### Call w/ Moritz

- models to try: Qwen, ++Kimi-K3-2.8B
- langchain


https://huggingface.co/Qwen/Qwen3.5-4B

- backend & inference (spark) trennen ?
    - REST API
- kleines model agentic, tool
- via RTX 4090 (24GB)
    - Qwen 3.5 9B
    - Qwen 3 8B
- ARDY auf Spark?

### Spark Specs
NVIDIA DGX Spark
- Architecture:
    - CPU: ARM64 (20-core: 10 Cortex-X925 and 10 Cortex-A725)
    - GPU: sm_121 Blackwell
- Chip / Processor: GB10
- Memory Capacity: 128 GB
- Bandwidth: 273 GB/s

### Links
https://docs.nvidia.com/dgx/dgx-spark/release-notes.html
https://vllm.ai/blog/2026-01-31-streaming-realtime#streaming-input-support-in-vllm
https://ai-muninn.com/en/blog/series/dgx-spark
https://spark-arena.com/
https://github.com/omnia-projetcs/spark-dgx
https://github.com/eugr/spark-vllm-docker
https://sparkbench.dev/

---

./launch-cluster.sh --solo -p 8000:8000 \
  -v /opt/huggingface_cache/hub:/root/.cache/huggingface/hub \
  exec vllm serve unsloth/gemma-4-E4B-it-NVFP4



https://note.com/fukuro_99/n/n26895f3edaad?hl=en
https://ai-muninn.com/en/blog/dgx-spark-30w-power-safety-mode

```sh
nvidia-smi --query-gpu=power.draw,utilization.gpu,clocks.sm --format=csv,noheader -l 1
```



- JF mit anderen mittwoch?
- wg office/ strom
- openai api
- RAG