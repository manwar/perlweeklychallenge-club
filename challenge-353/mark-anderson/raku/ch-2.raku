#!/usr/bin/env raku
use Test;

is-deeply validate-coupon(< A123 B_456 C789 D@1 E123 >,
                          < electronics restaurant electronics pharmacy grocery >,
                          < true false true true true >), (True, False, True, False, True);

is-deeply validate-coupon(< Z_9 AB_12 G01 X99 test >,
                          < pharmacy electronics grocery electronics unknown >,
                          < true true false true true >), (True, True, False, True, False);

is-deeply validate-coupon(<< _123 123 "" Coupon_A Alpha >>,
                          < restaurant electronics electronics pharmacy grocery >,
                          < true true false true true >), (True, True, False, True, True);

is-deeply validate-coupon(< ITEM_1 ITEM_2 ITEM_3 ITEM_4 >,
                          < electronics electronics grocery grocery >,
                          < true true true true >),       (True, True, True, True);

is-deeply validate-coupon(< CAFE_X ELEC_100 FOOD_1 DRUG_A ELEC_99 >,
                          < restaurant electronics grocery pharmacy electronics >,
                          < true true true true false >), (True, True, True, True, False);

sub validate-coupon(@codes, @names, @status)
{
    my @valid = < electronics grocery pharmacy restaurant >;

    ([Z] @codes, @names, @status).map({ so all .[0] ~~ /^ \w+ $/,
                                               .[1] (elem) @valid,
                                               .[2] eq "true" 
                                      })
}
