# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/308-1.bqn

u ⇐ •Import "/home/cph/bqn-test/test.bqn"

CommonCount ← +´∊

# Tests
u.UnitTest (⟨"perl", "weekly", "challenge"⟩ CommonCount ⟨"raku", "weekly", "challenge"⟩) ≡ 2
u.UnitTest      (⟨"perl", "raku", "python"⟩ CommonCount ⟨"python", "java"⟩)              ≡ 1
u.UnitTest       (⟨"guest", "contribution"⟩ CommonCount ⟨"fun", "weekly", "challenge"⟩)  ≡ 0
