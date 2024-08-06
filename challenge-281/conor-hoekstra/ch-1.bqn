# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/281-1.bqn

IsDark ← 2|·+´48|-⟜'0'¨

# Tests
•Show IsDark "d3" # 1
•Show IsDark "g5" # 0
•Show IsDark "e6" # 1
•Show IsDark "a1" # 0
