# For up to date code:
# https://github.com/codereport/bqn-code/blob/main/pwc/287-1.bqn

⟨Group⟩ ⇐ •Import "../lib/fun.bqn"
⟨IsDigit, IsLower, IsUpper⟩ ⇐ •Import "../lib/string.bqn"

MakeStrong ← {
    r ← +´⌊3÷˜≠¨Group𝕩 # replacements for repeating
    a ← 0⌈6-≠𝕩         # additions for length
    l ← ∨´IsLower¨𝕩    # has upper
    u ← ∨´IsUpper¨𝕩    # has lower
    d ← ∨´IsDigit¨𝕩    # has digit
    (r+a)⌈+´¬l∾u∾d
}

# Tests
•Show MakeStrong "a"         # 5
•Show MakeStrong "aB2"       # 3
•Show MakeStrong "PaaSW0rd"  # 0
•Show MakeStrong "Paaasw0rd" # 1
•Show MakeStrong "aaaaa"     # 2
•Show MakeStrong "aaaaaaaaa" # 3
