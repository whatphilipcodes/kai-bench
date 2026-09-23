RUN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RUN_NAME="$(basename "${BASH_SOURCE[0]%.*}")"
source "$RUN_DIR/../profiles.sh"

TOKENIZER="mistralai/Ministral-3-14B-Instruct-2512"

set_env
run_llama_benchy "$TOKENIZER" "$RUN_DIR" "$RUN_NAME"