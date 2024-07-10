# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/274-2.bqn

WaitForBus ← {
    t ← ⟨¯1‿0⟩∾∧∾{ e‿s‿d ← 𝕩 ⋄ (⋈⟜(d⊸+))¨s+e×↕⌈100÷e }¨𝕩
    60⊸>⊸/∾{⟨⟨a,b⟩,⟨c,d⟩,⟨e,f⟩⟩ ← 𝕩 ⋄ {f<d?1+a+↕c-a;⟨⟩}}¨<˘3↕t
}

# Tests
•Show WaitForBus ⟨⟨12,11,41⟩,⟨15,5,35⟩⟩          # [36,37,38,39,40,41,42,43,44,45,46,47]
•Show WaitForBus ⟨⟨12,3,41⟩,⟨15,9,35⟩,⟨30,5,25⟩⟩ # [0,1,2,3,25,26,27,40,41,42,43,44,45,46,47,48,49,50,51,55,56,57,58,59]
