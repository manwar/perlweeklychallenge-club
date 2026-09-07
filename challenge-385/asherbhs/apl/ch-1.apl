UncommonWords←(≠∧⌽∘≠∘⌽)⍛/,⍥(' '∘≠⍛⊆)

⎕←'apple banana apple' UncommonWords 'banana orange'
⎕←'cat dog' UncommonWords 'bird fish'
⎕←'the quick brown fox' UncommonWords 'the quick'
⎕←'hello' UncommonWords 'hello'
⎕←'blue blue red' UncommonWords 'red green green yellow'
