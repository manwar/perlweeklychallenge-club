|  Language  | Glyphs |                   Solution                   |
| :--------: | :----: | :------------------------------------------: |
|   Jelly    |   13   |              `I×ṕ<0SŒgṀ+2_E`                |
|    Uiua    |   26   |         `+1+⊃(±/+⌵)(/↥⊂0⊜/+.<0⧈×)⧈-`         |
|  TinyAPL   |   27   |        `{(1=≢∪⍵)-⍨2+0⌈/≢¨⊆⍨0>×⌺-⌺⍵}`         |
|    Kap     |   32   |      `(2+⌈/0,⍨≢¨⊂⍨0>2×/0,2-/)«-»(1=≢∪)`      |
| Dyalog APL |   35   |    `{d←×2-/⍵,⊢/⍵⋄1+⌈/0,\|d,1+≢¨⊆⍨0>2×/d}`    |
|    BQN     |   39   | ``{d←-´˘2↕𝕩⋄1+(∨´×\|d)+⌈´0∾(⊢×+)`0>1↓d×»d}`` |
|     J      |   40   | `{{(1=#~.y)-~2+>./([*+)/\.0,0>2*/\2-/\y}}`  |
|   Jello    |   46   | `deltas * prior < 0 sum group maxr + 2 _ all_eq` |

A negative product of adjacent differences marks a valid turn. Jelly, Jello,
TinyAPL, Kap, and J use `2 + longest turn run - all equal`; the other languages
retain shorter dialect-specific forms. Zero prefixes preserve the length-one
case.

Jello is counted as its 46-character keyword source, including required spaces;
Jelly is counted independently as its 13-glyph source.
