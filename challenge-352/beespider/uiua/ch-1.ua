# uiua 0.17.3
MatchString ← ▽⊸(↧₁ -₁ ≡/+ ˙⊞◇(/↥⌕))◴

┌─╴test
  ⍤⤙≍ {"cat" "dog" "dogcat" "rat"} MatchString {"cat" "cats" "dog" "dogcat" "dogcat" "rat" "ratcatdogcat"}
  ⍤⤙≍ {"hell" "world" "wor" "ellow"} MatchString {"hello" "hell" "world" "wor" "ellow" "elloworld"}
  ⍤⤙≍ {"a" "aa" "aaa"} MatchString {"a" "aa" "aaa" "aaaa"}
  ⍤⤙≍ {"flow" "fl" "fli" "ig" "ght"} MatchString {"flower" "flow" "flight" "fl" "fli" "ig" "ght"}
  ⍤⤙≍ {"car" "pet" "enter" "pen" "pent"} MatchString {"car" "carpet" "carpenter" "pet" "enter" "pen" "pent"}
└─╴
