a←'A'+↕26
CaesarCipher←{𝕨⊸{a⊏˜(𝕨⌽a)⊐𝕩}⌾((𝕩∊a)⊸/)𝕩}
3 CaesarCipher "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG"