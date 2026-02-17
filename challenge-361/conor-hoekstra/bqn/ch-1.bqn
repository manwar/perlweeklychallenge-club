# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/361-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

fib ← 2↓⊑¨+`∘⌽⍟(↕12)↕2

ZeckenDorf ← { 𝕊n:
  f ← 𝕩⊸≥⊸/fib    
  ⊑⟨⟩‿0{𝕨𝕊l‿b:{((¬b)∧n≥𝕩+´l)?(l∾𝕩)⋈1;l⋈0}𝕨}´f
} 

# Tests
u.UnitTest (ZeckenDorf   4) ≡ ⟨3,1⟩
u.UnitTest (ZeckenDorf  12) ≡ ⟨8,3,1⟩
u.UnitTest (ZeckenDorf  20) ≡ ⟨13,5,2⟩
u.UnitTest (ZeckenDorf  96) ≡ ⟨89,5,2⟩
u.UnitTest (ZeckenDorf 100) ≡ ⟨89,8,3⟩
