# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/292-1.bqn

TwiceLargest ← (¯1+2×∧´)·(⊑≥2×1↓⊢)∨

# Tests
•Show TwiceLargest 2‿4‿1‿0 # 1
•Show TwiceLargest 1‿2‿3‿4 # -1
