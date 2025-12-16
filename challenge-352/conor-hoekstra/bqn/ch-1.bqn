# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/352-1.bqn

u  ⇐ •Import "/home/cph/bqn-test/test.bqn"
fn ⇐ •Import "/home/cph/bqn-code/lib/fun.bqn"

MatchString ← { ⍷(⊑¨/˜{ ∨´(⊑𝕩)⊸fn.In¨1⊸↓ 𝕩 }¨)⌽⟜𝕩¨↕∘≠𝕩 }

# Tests
u.UnitTest (MatchString ⟨"cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"⟩) ≡ ⟨"cat", "dog", "dogcat", "rat"⟩
u.UnitTest (MatchString ⟨"hello", "hell", "world", "wor", "ellow", "elloworld"⟩) ≡ ⟨"hell", "world", "wor", "ellow"⟩
u.UnitTest (MatchString ⟨"a", "aa", "aaa", "aaaa"⟩) ≡ ⟨"a", "aa", "aaa"⟩
u.UnitTest (MatchString ⟨"flower", "flow", "flight", "fl", "fli", "ig", "ght"⟩) ≡ ⟨"flow", "fl", "fli", "ig", "ght"⟩
u.UnitTest (MatchString ⟨"car", "carpet", "carpenter", "pet", "enter", "pen", "pent"⟩) ≡ ⟨"car", "pet", "enter", "pen", "pent"⟩
