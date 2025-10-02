BrokenKeyboard ← { ≢∪(∊∘⍺(⊢~⊢⍤/)(+\' '=⊢))⎕C⍵ }

⍝ Tests
 'd' BrokenKeyboard 'Hello World'          ⍝ 1
'ae' BrokenKeyboard 'apple banana cherry'  ⍝ 0
  '' BrokenKeyboard 'Coding is fun'        ⍝ 3
'ab' BrokenKeyboard 'The Weekly Challenge' ⍝ 2
 'p' BrokenKeyboard 'Perl and Python'      ⍝ 1
