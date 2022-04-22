      ⍝ Load Dictionary
      dict ← ⊃⎕NGET '/home/cph/perlweeklychallenge-club/data/dictionary.txt' 1

      ⍝ Remove words with duplicates
      uniq ← dict/⍨(≢∘∪=≢)¨dict

      ⍝ Define pangram function
      pangram ← {
         26>≢∪∊⍵ : findNext ⍵,⊂(?∘≢⊃⊢)uniq/⍨(⊃(⌽⎕C ⎕A)~∊⍵)∘∊¨uniq ⋄ ⍵
      }

      ⍝ Find a "short" pangram
      ↑{⍵/⍨((⌊/=⊢)≢¨)⍵}pangram ¨ 10/⊂⍬
┌───────┬────┬──────┬─────────┬──────┬─────┬────────┬──────┐
│wizards│sexy│shoved│computing│quirks│bleat│jaundice│famous│
└───────┴────┴──────┴─────────┴──────┴─────┴────────┴──────┘

      ⍝ In (modified) sentence version:
      'Sexy wizards computing quirks on behalf of juveniles.'
