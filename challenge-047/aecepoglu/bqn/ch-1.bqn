# 1
roman←{
 rs←⌽"IVXLCDM"
 ds←⌽1‿5‿10‿50‿100‿500‿1000
 From⇐(+´∘((1‿¯1⊏˜⊢<«)×⊢)ds⊏˜rs⊸⊐)
 To  ⇐{x←<˘⍉˘⍉ >2↑¨ (+`2|↕∘≠)⊸⊔˘ds≍˜ 1⊑¨(<𝕩‿0)⊑⊸(|˜⋈⌊∘÷)` ds
       ∾´{[a,b]:⟨a⟩/(rs∾@)⊏˜ds⊐b}∘{[a‿4,c‿d]:[1‿1,d⋈c×a+1];𝕩}¨x }
 #TEST roman.From∘roman.To¨⊸≡ ↕200
}

"VII" (roman.To∘+○roman.From) "XXXXII" # TODO blog post about this
