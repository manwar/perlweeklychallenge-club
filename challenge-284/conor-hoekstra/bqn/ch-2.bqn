# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/284-2.bqn

RelativeSort  ← {(𝕨/˜+˝𝕩=⌜𝕨)∾∧𝕩/˜¬𝕩∊𝕨} # Explicit
RelativeSort2 ← ((+˝=⌜˜)/⊣)∾·∧(¬∊˜)/⊢  # Tacit

# Tests
•Show ⟨2,1,4,3,5,6⟩ RelativeSort  ⟨2,3,9,3,1,4,6,7,2,8,5⟩ # ⟨2,2,1,4,3,3,5,6,7,8,9⟩
•Show       ⟨1,3,2⟩ RelativeSort  ⟨3,3,4,6,2,4,2,1,3⟩     # ⟨1,3,3,3,2,2,4,4,6⟩
•Show     ⟨1,0,3,2⟩ RelativeSort  ⟨3,0,5,0,2,1,4,1,1⟩     # ⟨1,1,1,0,0,3,2,4,5⟩
•Show ⟨2,1,4,3,5,6⟩ RelativeSort2 ⟨2,3,9,3,1,4,6,7,2,8,5⟩ # ⟨2,2,1,4,3,3,5,6,7,8,9⟩
•Show       ⟨1,3,2⟩ RelativeSort2 ⟨3,3,4,6,2,4,2,1,3⟩     # ⟨1,3,3,3,2,2,4,4,6⟩
•Show     ⟨1,0,3,2⟩ RelativeSort2 ⟨3,0,5,0,2,1,4,1,1⟩     # ⟨1,1,1,0,0,3,2,4,5⟩
