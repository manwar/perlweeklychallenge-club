#! /usr/bin/raku

use Test;

plan 5;

is-deeply(validatecoupon(['A123', 'B_456', 'C789', 'D@1', 'E123'], ['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'], [True, False, True, True, True]), [True, False, True, False, True], 'example 1');
is-deeply(validatecoupon(['Z_9', 'AB_12', 'G01', 'X99', 'test'], ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'], [True, True, False, True, True]), [True, True, False, True, False], 'example 2');
is-deeply(validatecoupon(['_123', '123', '', 'Coupon_A', 'Alpha'], ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'], [True, True, False, True, True]), [True, True, False, True, True], 'example 3');
is-deeply(validatecoupon(['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'], ['electronics', 'electronics', 'grocery', 'grocery'], [True, True, True, True]), [True, True, True, True], 'example 4');
is-deeply(validatecoupon(['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'], ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'], [True, True, True, True, False]), [True, True, True, True, False], 'example 5');

sub validatecoupon(@codes, @names, @status) {
    my %dep = ["electronics", "grocery", "pharmacy", "restaurant"].Set;
    my @out;
    for 0 .. @codes.end -> $i {
        if (@codes[$i] ~~ /^<[0..9A..Za..z_]>+$/) &&
        (%dep{@names[$i]}:exists) &&
        @status[$i] {
            @out.push(True);
        } else {
            @out.push(False);
        }
    }
    @out;
}
