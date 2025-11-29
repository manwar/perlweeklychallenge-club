ParseLetter ← +⍣(0_1 °@U|0_¯1 °@D|1_0 °@R|¯1_0 °@L)
MatchPt     ← ∊⊙0_0∧(⟜∘ParseLetter) ⊙0_0

⍤⤙≍ 0 MatchPt "ULD"
⍤⤙≍ 1 MatchPt "UDLR"
⍤⤙≍ 0 MatchPt "UUURRRDDD"
⍤⤙≍ 1 MatchPt "UURRRDDLLL"
⍤⤙≍ 1 MatchPt "RRUULLDDRRUU"
