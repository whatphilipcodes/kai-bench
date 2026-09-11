PROFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_PATH="$PROFILES_DIR/../.env"

set_env() {
  if [ -f "${ENV_PATH}" ]; then
    set -a
    source "${ENV_PATH}"
    set +a
  fi
}

BASE_URL="http://localhost:8000"
PROMPT_PROCESSING="2048"
TOKEN_GENERATION="128"
CONCURRENCY="1 2"
DEPTH="0 4096 8192 16384"
# DEPTH="0"

run_llama_benchy() {
  local tokenizer="${1}"
  local run_dir="${2}/results"
  local run_name="${3}"

  mkdir -p "${run_dir}"

  local artifact="${run_dir}/${run_name}-$(date +%Y%m%d_%H%M%S).md"
  local tmp_gpu_log="${run_dir}/${run_name}-gpu-log.csv"
  local tmp_info="${run_dir}/${run_name}-info.txt"

  nvidia-smi --query-gpu=timestamp,power.draw,utilization.gpu,clocks.sm --format=csv,noheader -l 1 > "${tmp_gpu_log}" &
  local nvidia_smi_pid=$!

  uv run llama-benchy \
    --base-url "$BASE_URL/v1" \
    --tokenizer "${tokenizer}" \
    --pp ${PROMPT_PROCESSING} \
    --depth ${DEPTH} \
    --tg "${TOKEN_GENERATION}" \
    --concurrency ${CONCURRENCY} \
    --latency-mode generation \
    --enable-prefix-caching \
    --extra-body return_token_ids=false \
    --save-result "${artifact}"

  kill ${nvidia_smi_pid} 2>/dev/null

  echo "## System" > "${tmp_info}"
  nvidia-smi --query-gpu=name,driver_version,memory.total --format=csv,noheader >> "${tmp_info}"
  echo "" >> "${tmp_info}"
  echo "## Llama-Benchy" >> "${tmp_info}"

  cat "${artifact}" >> "${tmp_info}"

  echo "" >> "${tmp_info}"
  echo "" >> "${tmp_info}"
  echo "## Resources" >> "${tmp_info}"
  echo "| Timestamp | Power Draw | GPU Utilization | SM Clock |" >> "${tmp_info}"
  echo "|---|---|---|---|" >> "${tmp_info}"
  
  sed 's/, */ | /g; s/^/| /; s/$/ |/' "${tmp_gpu_log}" >> "${tmp_info}"

  mv "${tmp_info}" "${artifact}"

  rm -f "${tmp_gpu_log}"
}