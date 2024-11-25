# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/297-1.bqn

⟨UnitTest⟩ ⇐ •Import "/home/cph/bqn-test/test.bqn"

MaximumLength  ← ⌈´0∾1+·∾·(/0=+`)¨·↓¯1+2×⊢ # Tacit
MaximumLength2 ← {⌈´0∾1+∾(/0=+`)¨↓¯1+2×𝕩}  # Explicit

# Tests
UnitTest (MaximumLength 1‿0)         ≡ 2
UnitTest (MaximumLength 0‿1‿0)       ≡ 2
UnitTest (MaximumLength 5⥊0)         ≡ 0
UnitTest (MaximumLength 0‿1‿0‿0‿1‿0) ≡ 4

UnitTest (MaximumLength2 1‿0)         ≡ 2
UnitTest (MaximumLength2 0‿1‿0)       ≡ 2
UnitTest (MaximumLength2 5⥊0)         ≡ 0
UnitTest (MaximumLength2 0‿1‿0‿0‿1‿0) ≡ 4
