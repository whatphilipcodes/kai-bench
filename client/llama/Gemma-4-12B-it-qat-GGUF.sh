RUN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUN_NAME="$(basename "${BASH_SOURCE[0]%.*}")"
source "$RUN_DIR/../profiles.sh"

TOKENIZER="google/gemma-4-12B-it-qat-q4_0-unquantized"

set_env
run_llama_benchy "$TOKENIZER" "$RUN_DIR" "$RUN_NAME"