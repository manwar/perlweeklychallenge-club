# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/078-1.bqn

LeaderElement ← ⍷⌈`⌾⌽

# Tests
•Show LeaderElement ⟨9, 10, 7, 5, 6, 1⟩ # ⟨10, 7, 6, 1⟩
•Show LeaderElement ⟨3, 4, 5⟩ # ⟨5⟩
