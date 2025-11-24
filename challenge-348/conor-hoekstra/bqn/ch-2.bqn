# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/348-2.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

Convert ← 2⊸↑ 60⊸×⊸+○•BQN 3⊸↓
Count   ← { a ← ⌊𝕩÷60 ⋄ b ← ⌊(𝕩-60×a)÷15 ⋄ c ← (𝕩-+´60‿15×a‿b)÷5 ⋄ +´a‿b‿c }
ConvertTime ← Count·(1440⊸-⊸⌊)|∘-○Convert

# Tests
u.UnitTest ("02:30" ConvertTime "02:45") ≡ 1
u.UnitTest ("11:55" ConvertTime "12:15") ≡ 2
u.UnitTest ("09:00" ConvertTime "13:00") ≡ 4
u.UnitTest ("23:45" ConvertTime "00:30") ≡ 3
u.UnitTest ("14:20" ConvertTime "15:25") ≡ 2
