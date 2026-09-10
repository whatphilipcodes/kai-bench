PROFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$PROFILES_DIR/../.env"

set_env() {
  if [ -f "$ENV_PATH" ]; then
    set -a
    source "$ENV_PATH"
    set +a
  fi
}

BASE_URL="http://localhost:8000"
PROMPT_PROCESSING="2048"
TOKEN_GENERATION="128"
CONCURRENCY="1 2"
DEPTH="0"
# DEPTH="0 4096 8192 16384"

run_llama_benchy() {
  local tokenizer="$1"
  local run_dir="$2"
  local run_name="$3"

  local artifact_dir="${run_dir}/${run_name}-$(date +%Y%m%d_%H%M%S).md"
  local tmp_gpu_log="${run_dir}/${run_name}-gpu-log.csv"

  nvidia-smi --query-gpu=timestamp,power.draw,utilization.gpu,clocks.sm --format=csv,noheader -l 1 > "$tmp_gpu_log" &
  local nvidia_smi_pid=$!

  uv run llama-benchy \
    --base-url "$BASE_URL/v1" \
    --tokenizer "$tokenizer" \
    --pp $PROMPT_PROCESSING \
    --depth $DEPTH \
    --tg "$TOKEN_GENERATION" \
    --concurrency $CONCURRENCY \
    --latency-mode generation \
    --enable-prefix-caching \
    --extra-body return_token_ids=false \
    --save-result "$artifact_dir"

  kill $nvidia_smi_pid 2>/dev/null

  sed -i '1s/^/## Llama-Benchy\n/' "$artifact_dir"
  echo "" >> "$artifact_dir"
  echo "" >> "$artifact_dir"
  echo "## System" >> "$artifact_dir"
  echo "| Timestamp | Power Draw | GPU Utilization | SM Clock |" >> "$artifact_dir"
  echo "|---|---|---|---|" >> "$artifact_dir"
  
  sed 's/, */ | /g; s/^/| /; s/$/ |/' "$tmp_gpu_log" >> "$artifact_dir"

  rm -f "$tmp_gpu_log"
}