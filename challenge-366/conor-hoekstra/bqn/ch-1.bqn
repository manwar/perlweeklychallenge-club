# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/366-1.bqn
# https://arraybox.dev/#en9v

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Cp  ← { +´𝕩∊↑𝕨 } # Explicit
Cp2 ← +´⊢∊↑∘⊣    # Tacit

# Tests
u.UnitTest (  "apple" Cp ⟨"a", "ap", "app", "apple", "banana"⟩) ≡ 4
u.UnitTest (   "bird" Cp ⟨"cat", "dog", "fish"⟩) ≡ 0
u.UnitTest (  "hello" Cp ⟨"hello", "he", "hell", "heaven", "he"⟩) ≡ 4
u.UnitTest ( "coding" Cp ⟨"", "code", "coding", "cod"⟩) ≡ 3
u.UnitTest ("program" Cp ⟨"p", "pr", "pro", "prog", "progr", "progra", "program"⟩) ≡ 7

u.UnitTest (  "apple" Cp2 ⟨"a", "ap", "app", "apple", "banana"⟩) ≡ 4
u.UnitTest (   "bird" Cp2 ⟨"cat", "dog", "fish"⟩) ≡ 0
u.UnitTest (  "hello" Cp2 ⟨"hello", "he", "hell", "heaven", "he"⟩) ≡ 4
u.UnitTest ( "coding" Cp2 ⟨"", "code", "coding", "cod"⟩) ≡ 3
u.UnitTest ("program" Cp2 ⟨"p", "pr", "pro", "prog", "progr", "progra", "program"⟩) ≡ 7