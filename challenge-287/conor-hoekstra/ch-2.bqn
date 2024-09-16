# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/287-2.bqn

⟨Split⟩ ⇐ •Import "../lib/string.bqn"

RemSign     ← (∨´"-+"=⊑)⊸↓
ValidNat    ← ∧´∊⟜('0'+↕10)
ValidDec    ← (×´×+´)·ValidNat¨·'.'⊸Split RemSign
ValidInt    ← ∧´·ValidNat∘RemSign¨'e'⊸Split
ValidNumber ← (⊑'.'⊸∊)◶ValidInt‿ValidDec

# Tests
•Show ValidNumber "1"       # 1
•Show ValidNumber "a"       # 0
•Show ValidNumber "."       # 0
•Show ValidNumber "1.2e4.2" # 0
•Show ValidNumber "-1."     # 1
•Show ValidNumber "+1e-8"   # 1
•Show ValidNumber ".44"     # 1
•Show ValidNumber "-."      # 0
•Show ValidNumber "-.1"     # 1
•Show ValidNumber "-.-1"    # 0
