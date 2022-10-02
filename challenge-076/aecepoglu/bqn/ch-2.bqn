p←["bidemiatsuccorst",
   "ldeggiwqhodeehdp",
   "useirubuteaslagu",
   "ngnizilaicoscnud",
   "tgmidstsarareifg",
   "srenmdchasiveeli",
   "scshaeuebroadmte",
   "hwovlpeddlaiulss",
   "ryonlasfcstaogot",
   "igussrrugovaryoc",
   "nrgpatnangilamoo",
   "eihaceivirusesed",
   "setsudttgarlicnh",
   "hvrmxlwiumsnsotb",
   "aeaofilchtodcaeu",
   "zscdfecaaiirlnrf",
   "ariianyutoooutpf",
   "rsecisnaboscnera",
   "drsmpcuuneltesil"]
w←((∧´1="a{"⊸⍋)¨∧(5≤≠¨))⊸/ •FLines"/usr/share/dict/american-english"
Diags←{∾´((5≤≠¨)⊸/∘(+´¨⊔⊢)∘⥊∘↕∘≢⊑¨<∘⊢)¨(⌽⋈⊢)𝕩}
w ((∨˝∘⍉∨´∘⍷⌜)/⊣) ⌽¨⊸∾((<˘)∾(<˘⍉)∾Diags)p # solution
