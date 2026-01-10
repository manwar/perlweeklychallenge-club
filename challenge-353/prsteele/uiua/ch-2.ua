# Uiua 0.18.0-dev.4

AlphaNumUnd ← ↥↥↥∩₃↧⊃(≥@a|≤@z|≥@A|≤@Z|≥@0|≤@9|=@_)
Names       ← {"electronics" "grocery" "pharmacy" "restaurant"}

Valid ← ≡(××◇⊃(/×AlphaNumUnd|⋅(∊Names□)|⋅⋅(≍"true")))

┌─╴test
  {"true" "false" "true" "true" "true"}
  {"electronics" "restaurant" "electronics" "pharmacy" "grocery"}
  {"A123" "B_456" "C789" "D@1" "E123"}
  ⍤⤙≍ [1 0 1 0 1] Valid

  {"true" "true" "false" "true" "true"}
  {"pharmacy" "electronics" "grocery" "electronics" "unknown"}
  {"Z_9" "AB_12" "G01" "X99" "test"}
  ⍤⤙≍ [1 1 0 1 0] Valid

  {"true" "true" "false" "true" "true"}
  {"restaurant" "electronics" "electronics" "pharmacy" "grocery"}
  {"_123" "123" "" "Coupon_A" "Alpha"}
  ⍤⤙≍ [1 1 0 1 1] Valid

  {"true" "true" "true" "true"}
  {"electronics" "electronics" "grocery" "grocery"}
  {"ITEM_1" "ITEM_2" "ITEM_3" "ITEM_4"}
  ⍤⤙≍ [1 1 1 1] Valid

  {"true" "true" "true" "true" "false"}
  {"restaurant" "electronics" "grocery" "pharmacy" "electronics"}
  {"CAFE_X" "ELEC_100" "FOOD_1" "DRUG_A" "ELEC_99"}
  ⍤⤙≍ [1 1 1 1 0] Valid
└─╴
