#!/usr/local/bin/jconsole

require 'regex'
cat =: 'electronics'; 'grocery'; 'pharmacy'; 'restaurant'
words =: (<;._1)@(' '&,) L:0
ValidCoupon =: (<'true')&(e.~)@(2&{) *. cat&(e.~)@(1&{) *. >@('^\w+$'&rxeq&.>)@(0&{)

NB. split at NL, split §-delimited examples, split words and unbox inner boxes
examples =: > L:2 words <;._1 cutopen 0 : 0
§
A123 B_456 C789 D@1 E123
electronics restaurant electronics pharmacy grocery
true false true true true
§
Z_9 AB_12 G01 X99 test
pharmacy electronics grocery electronics unknown
true true false true false
§
_123 123  Coupon_A Alpha
restaurant electronics electronics pharmacy grocery
true true false true true
§
ITEM_1 ITEM_2 ITEM_3 ITEM_4
electronics electronics grocery grocery
true true true true
§
CAFE_X ELEC_100 FOOD_1 DRUG_A ELEC_99
restaurant electronics grocery pharmacy electronics
true true true true false
)

expected =: (<1 0 1 0 1), (<1 1 0 1 0), (<1 1 0 1 1), (<1 1 1 1), (<1 1 1 1 0)

3 : 0 (2}. ARGV)
if.
    3 = # y
do.
    echo ValidCoupon > words y
elseif.
    0 = # y
do.
    try.
        assert expected -: ValidCoupon &.> examples
        echo 'tests succeeded'
    catch.
        echo 'tests failed'
        echo 13!:12''
    end.
else.
    echo 'Call "./ch-1.ijs CODES CATEGORIES STATUS" to process coupons'
    echo 'or   "./ch-1.ijs"                         to run the examples'
end.
)

exit^:(0&>@(4!:0) <'noexit') ''