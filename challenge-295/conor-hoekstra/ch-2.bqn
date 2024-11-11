# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/295-2.bqn
# This is also: https://leetcode.com/problems/jump-game-ii

JumpGame ← {
    m ← ⌈`𝕩+i←↕≠𝕩
    { ∨´i≥m ? ¯1 ; ¯1+≠⍷m }
}

# Tests
•Show JumpGame 2‿3‿1‿1‿4 # 2
•Show JumpGame 2‿3‿0‿4   # 2
•Show JumpGame 2‿0‿0‿4   # ¯1
