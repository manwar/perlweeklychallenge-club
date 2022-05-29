      dirs    ← ('Arial.ttf' 'Comic_Sans.ttf' ⍝ ...
      headers ← ('Dir A')('Dir B')('Dir C')      

      ⍝ Formatted data
      headers⍪⍉↑dirs
┌──────────────┬───────────────┬───────────────┐
│Dir A         │Dir B          │Dir C          │
├──────────────┼───────────────┼───────────────┤
│Arial.ttf     │Arial.ttf      │Arial.ttf      │
├──────────────┼───────────────┼───────────────┤
│Comic_Sans.ttf│Comic_Sans.ttf │Courier_New.ttf│
├──────────────┼───────────────┼───────────────┤
│Georgia.ttf   │Courier_New.ttf│Helvetica.ttf  │
├──────────────┼───────────────┼───────────────┤
│Helvetica.ttf │Helvetica.ttf  │Impact.otf     │
├──────────────┼───────────────┼───────────────┤
│Impact.otf    │Impact.otf     │Monaco.ttf     │
├──────────────┼───────────────┼───────────────┤
│Verdana.ttf   │Tahoma.ttf     │Verdana.ttf    │
├──────────────┼───────────────┼───────────────┤
│Old_Fonts/    │Verdana.ttf    │               │
└──────────────┴───────────────┴───────────────┘

      u ← ∪⊃,/dirs       ⍝ unique
      c ← u/⍨⊃∧/u∘∊¨dirs ⍝ common

      headers⍪⍉↑{c~⍨⍵/¨u}¨u∘∊¨dirs
┌──────────────┬───────────────┬───────────────┐
│Dir A         │Dir B          │Dir C          │
├──────────────┼───────────────┼───────────────┤
│Comic_Sans.ttf│Comic_Sans.ttf │               │
├──────────────┼───────────────┼───────────────┤
│Georgia.ttf   │               │               │
├──────────────┼───────────────┼───────────────┤
│Old_Fonts/    │               │               │
├──────────────┼───────────────┼───────────────┤
│              │Courier_New.ttf│Courier_New.ttf│
├──────────────┼───────────────┼───────────────┤
│              │Tahoma.ttf     │               │
├──────────────┼───────────────┼───────────────┤
│              │               │Monaco.ttf     │
└──────────────┴───────────────┴───────────────┘