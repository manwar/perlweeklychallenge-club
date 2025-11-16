# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/347-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"
s ⇐ •Import "/home/cph/bqn-code/lib/string.bqn"

months ← ""‿"Jan"‿"Feb"‿"Mar"‿"Apr"‿"May"‿"Jun"‿"Jul"‿"Aug"‿"Sep"‿"Oct"‿"Nov"‿"Dec"
Pad    ← (1=≠)◶⟨⊢,"0"⊸∾⟩
Format ← { 𝕊d‿m‿y: "-" s.Join ⟨y,Pad•Fmt⊑months⊐⋈m,Pad ¯2↓d⟩ } s.Words

# Tests
u.UnitTest (Format  "1st Jan 2025") ≡ "2025-01-01"
u.UnitTest (Format "22nd Feb 2025") ≡ "2025-02-22"
u.UnitTest (Format "15th Apr 2025") ≡ "2025-04-15"
u.UnitTest (Format "23rd Oct 2025") ≡ "2025-10-23"
u.UnitTest (Format "31st Dec 2025") ≡ "2025-12-31"
