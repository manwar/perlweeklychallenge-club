# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/360-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

TextJustifier  ← { ∾¯1⌽(⋈𝕩)∾/⟜"*"¨(⌈⋈⌊)2÷˜𝕨-≠𝕩 } # Solution 1 (explicit)
TextJustifier2 ← { ∾¯1⌽𝕩∾(⌈⋈○(/⟜"*")⌊)2÷˜𝕨-≠𝕩 }  # Solution 2 (explicit)
TextJustifier3 ← ∾¯1⌽⊢∾((⌈⋈○(/⟜"*")⌊)2÷˜-⟜≠)     # Solution 3 (tacit)

# Tests
u.UnitTest ( 5 TextJustifier "Hi")    ≡ "*Hi**"
u.UnitTest (10 TextJustifier "Code")  ≡ "***Code***"
u.UnitTest ( 9 TextJustifier "Hello") ≡ "**Hello**"
u.UnitTest ( 4 TextJustifier "Perl")  ≡ "Perl"
u.UnitTest ( 7 TextJustifier "A")     ≡ "***A***"
u.UnitTest ( 5 TextJustifier "")      ≡ "*****"

u.UnitTest ( 5 TextJustifier2 "Hi")    ≡ "*Hi**"
u.UnitTest (10 TextJustifier2 "Code")  ≡ "***Code***"
u.UnitTest ( 9 TextJustifier2 "Hello") ≡ "**Hello**"
u.UnitTest ( 4 TextJustifier2 "Perl")  ≡ "Perl"
u.UnitTest ( 7 TextJustifier2 "A")     ≡ "***A***"
u.UnitTest ( 5 TextJustifier2 "")      ≡ "*****"

u.UnitTest ( 5 TextJustifier3 "Hi")    ≡ "*Hi**"
u.UnitTest (10 TextJustifier3 "Code")  ≡ "***Code***"
u.UnitTest ( 9 TextJustifier3 "Hello") ≡ "**Hello**"
u.UnitTest ( 4 TextJustifier3 "Perl")  ≡ "Perl"
u.UnitTest ( 7 TextJustifier3 "A")     ≡ "***A***"
u.UnitTest ( 5 TextJustifier3 "")      ≡ "*****"
