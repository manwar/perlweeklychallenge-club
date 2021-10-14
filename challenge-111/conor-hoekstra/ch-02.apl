solution ← {
   s ← ⍵/⍨(⊢≡⍳∘≢)∘⍋¨⍵
   ⊃s/⍨(⌈/=⊢)≢¨s
}

⍝ Tests
solution 'ant' 'cat' 'dog' 'bee' 'deer' 'mouse' ⍝ deer
solution 'aNt' 'Cat' 'dog' 'bee' 'Deer' 'mouse' ⍝ Deer
