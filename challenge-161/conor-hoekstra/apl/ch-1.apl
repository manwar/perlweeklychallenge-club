      ⍝ Load Dictionary
      dict ← ⊃⎕NGET '/home/cph/perlweeklychallenge-club/data/dictionary.txt' 1

      ⍝ Check First 5 Words
      ↑5↑dict
a
aardvark
aback
abacus
abacuses

      ⍝ Abecedarian Function
      Abecedarian ← ∧/2≤/(⎕C⎕A)⍳⊢

      ⍝ Collecting Abecedarian Words of First 100
      ↑(Abecedarian¨⊢⍤/⊢) 100↑d
a
abbey
abbot
abet
abhor
abhors
ably
abort

      ⍝ Total Count of Abecedarian Words in Dict
      +/Abecedarian¨d
319

      ⍝ Top 10 Longest Abecedarian Words
      ↑10↑((⊂∘⍒≢¨)⌷⊢)(Abecedarian¨⊢⍤/⊢)d
abhors
accent
accept
access
accost
almost
begins
bellow
billow
cellos
      ⍝ A short comment in your code to make your reviewer smile
      A floppy fox hops in a mossy den.
