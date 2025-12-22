#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

my %IS_CATEGORY;
@IS_CATEGORY{qw{ electronics grocery pharmacy restaurant }} = ();

sub validate_coupon($codes, $names, $status) {
    map $codes->[$_] =~ /^[_0-9a-zA-Z]+$/
        && exists $IS_CATEGORY{ $names->[$_] }
        && $status->[$_],
    0 .. $#$codes
}

use Test2::V0;
use constant { true => !! 1, false => !! 0 };
plan(5);

is [validate_coupon(
    ['A123', 'B_456', 'C789', 'D@1', 'E123'],
    ['electronics', 'restaurant', 'electronics', 'pharmacy', 'grocery'],
    [true, false, true, true, true]
)], [map bool($_), true, false, true, false, true],
'Example 1';

is [validate_coupon(
    ['Z_9', 'AB_12', 'G01', 'X99', 'test'],
    ['pharmacy', 'electronics', 'grocery', 'electronics', 'unknown'],
    [true, true, false, true, true]
)], [map bool($_), true, true, false, true, false],
'Example 2';

is [validate_coupon(
    ['_123', '123', '', 'Coupon_A', 'Alpha'],
    ['restaurant', 'electronics', 'electronics', 'pharmacy', 'grocery'],
    [true, true, false, true, true]
)], [map bool($_), true, true, false, true, true],
'Example 3';

is [validate_coupon(
    ['ITEM_1', 'ITEM_2', 'ITEM_3', 'ITEM_4'],
    ['electronics', 'electronics', 'grocery', 'grocery'],
    [true, true, true, true]
)], [map bool($_), true, true, true, true],
'Example 4';

is [validate_coupon(
    ['CAFE_X', 'ELEC_100', 'FOOD_1', 'DRUG_A', 'ELEC_99'],
    ['restaurant', 'electronics', 'grocery', 'pharmacy', 'electronics'],
    [true, true, true, true, false]
)], [map bool($_), true, true, true, true, false],
'Example 5';
