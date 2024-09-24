# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/288-2.bqn

deltas  ← ⌽¨⊸∾0⋈¨1‿¯1

MaxContiguousBlocks ← { 𝕊orig:
    empty ← 0⥊˜≢orig
    IsValid ← ∧´≥⟜0‿0∾(≢orig)>⊢
    FloodFill ← { 𝕊sym‿todo‿mat:
        { 0=≠todo ? +´⥊mat ;
        pos ← ⊑todo
        new ← IsValid¨⊸/pos⊸+¨deltas
        FloodFill { (sym=pos⊑orig)∧¬pos⊑mat
            ? sym‿(new∾˜1↓todo)‿(1⊸+⌾(pos⊸⊑)mat)
            ; sym‿(1↓todo)‿mat }}
    }
    ⌈´FloodFill¨{(𝕩⊑orig)‿⟨𝕩⟩‿empty}¨⥊↕≢orig
}

# Tests
•Show MaxContiguousBlocks >⟨"xxxxo",
                            "xoooo",
                            "xoooo",
                            "xxxoo"⟩ # 11

•Show MaxContiguousBlocks >⟨"xxxxx",
                            "xoooo",
                            "xxxxo",
                            "xoooo"⟩ # 11
•Show MaxContiguousBlocks >⟨"xxxoo",
                            "oooxx",
                            "oxxoo",
                            "oooxx"⟩ # 7
