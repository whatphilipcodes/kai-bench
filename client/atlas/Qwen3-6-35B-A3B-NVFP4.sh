RUN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUN_NAME="$(basename "${BASH_SOURCE[0]%.*}")"
source "$RUN_DIR/../profiles.sh"

TOKENIZER="Sehyo/Qwen3.5-35B-A3B-NVFP4"

set_env
run_llama_benchy "$TOKENIZER" "$RUN_DIR" "$RUN_NAME"