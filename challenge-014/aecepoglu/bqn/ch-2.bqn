words←(0=2|≠¨)⊸/("az"⊸(∧´1≤⍋)¨/⊢)+⟜(32×1="A["⊸⍋)¨•FLines"/usr/share/dict/american-english"
a←"al"‿"ak"‿"az"‿"ar"‿"ca"‿"co"‿"ct"‿"de"‿"fl"‿"ga"‿"hi"‿"id"‿"il"‿"in"‿"ia"‿"ks"‿"ky"‿"la"‿"me"‿"md"‿"ma"‿"mi"‿"mn"‿"ms"‿"mo"‿"mt"‿"ne"‿"nv"‿"nh"‿"nj"‿"nm"‿"ny"‿"nc"‿"nd"‿"oh"‿"ok"‿"or"‿"pa"‿"ri"‿"sc"‿"sd"‿"tn"‿"tx"‿"ut"‿"vt"‿"va"‿"wa"‿"wv"‿"wi"‿"wy"
C←{/⟜𝕩˘𝕨((⊣=·+´˘⊢)/⊢)>⥊↕2⥊˜≠𝕩}
((⌈´=⊢)∘(≠¨)/⊢)x←({{∨´(∧´∨˝)˘(⌈2÷˜1⊑≢)⊸C(∨´˘/(»∨⊢)˘)𝕩}¨<∘>∘⥊˘⍉a⍷⌜𝕩}/⊢)words
