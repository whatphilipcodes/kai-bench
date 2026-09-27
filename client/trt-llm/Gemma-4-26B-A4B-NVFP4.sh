RUN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUN_NAME="$(basename "${BASH_SOURCE[0]%.*}")"
source "$RUN_DIR/../profiles.sh"

TOKENIZER="nvidia/Gemma-4-26B-A4B-NVFP4"

set_env
run_llama_benchy "$TOKENIZER" "$RUN_DIR" "$RUN_NAME"