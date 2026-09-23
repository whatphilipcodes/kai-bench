RUN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUN_NAME="$(basename "${BASH_SOURCE[0]%.*}")"
source "$RUN_DIR/../profiles.sh"

TOKENIZER="nvidia/NVIDIA-Nemotron-3.5-Lightning-30B-A3B-NVFP4"

set_env
run_llama_benchy "$TOKENIZER" "$RUN_DIR" "$RUN_NAME"