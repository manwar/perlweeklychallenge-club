# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/296-2.bqn

Bfs ← { 𝕊t‿n‿s‿l: {
    4=n       ? 1 ;
    t=s       ? Bfs ⟨t,n+1,0,l⟩ ;
    0=≠l      ? 0 ;
    0=∨´t≥s+l ? 0 ;
    m ← ∊⊸∧t≥s+l
    Bfs ⟨t,n,s+⊑m/l,l/˜¬m⟩
}}

IsMatchstickSquare ← {
    0≠4|+´𝕩 ? 0 ;
    Bfs ⟨4÷˜+´𝕩,0,0,∨𝕩⟩
}

# Tests
•Show IsMatchstickSquare ⟨1, 2, 2, 2, 1⟩    # 1
•Show IsMatchstickSquare ⟨2, 2, 2, 4⟩       # 0
•Show IsMatchstickSquare ⟨2, 2, 2, 2, 4⟩    # 0
•Show IsMatchstickSquare ⟨3, 4, 1, 4, 3, 1⟩ # 1
