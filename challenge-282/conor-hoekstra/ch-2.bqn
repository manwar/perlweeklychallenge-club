# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/282-2.bqn

⟨Lower⟩  ⇐ •Import "../lib/string.bqn"
⟨Differ⟩ ⇐ •Import "../lib/fun.bqn"

Changes ← +´ · Differ Lower

# Tests

•Show Changes "pPeERrLl" # 3
•Show Changes "rRr"      # 0
•Show Changes "GoO"      # 1
