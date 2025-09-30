# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/336-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Step ← { x 𝕊 nums: {
    x≡"C" ? 1↓nums ;
    x≡"D" ? ( 2×⊑nums)∾nums ;
    x≡"+" ? (+´2↑nums)∾nums ;
    (•BQN x)∾nums }
}

FinalScore ← { +´(⋈•BQN ⊑𝕩) Step´ ⌽1↓𝕩 }

# Tests
u.UnitTest (FinalScore ⟨"5","2","C","D","+"⟩)                          ≡ 30
u.UnitTest (FinalScore ⟨"5","-2","4","C","D","9","+","+"⟩)             ≡ 27
u.UnitTest (FinalScore ⟨"7","D","D","C","+","3"⟩)                      ≡ 45
u.UnitTest (FinalScore ⟨"-5","-10","+","D","C","+"⟩)                   ≡ ¯55
u.UnitTest (FinalScore ⟨"3","6","+","D","C","8","+","D","-2","C","+"⟩) ≡ 128
