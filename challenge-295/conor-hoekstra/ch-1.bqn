# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/295-1.bqn

WorkBreak ← {
   0=≠𝕨 ? 1 ;
   n ← ≠∾𝕩/˜⊑¨⍷⟜𝕨¨𝕩
   𝕨{ 0=n ? 0 ; (n↓𝕨)WorkBreak𝕩 }𝕩
}

# Tests
•Show  "weeklychallenge" WorkBreak ⟨"challenge", "weekly"⟩       # 1
•Show     "perlrakuperl" WorkBreak ⟨"raku", "perl"⟩              # 1
•Show "sonsanddaughters" WorkBreak ⟨"sons", "sand", "daughters"⟩ # 0
