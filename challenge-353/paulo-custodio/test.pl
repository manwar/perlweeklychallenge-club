#!/usr/bin/env perl

use Modern::Perl;
use Test::More;
require "../../challenge-001/paulo-custodio/testlib.pl";

test_line(1, '"Hello world" "This is a test" "Perl is great"', 4);
test_line(1, '"Single"', 1);
test_line(1, '"Short" "This sentence has seven words in total" "A B C" "Just four words here"', 7);
test_line(1, '"One" "Two parts" "Three part phrase" ""', 3);
test_line(1, '"The quick brown fox jumps over the lazy dog" "A" "She sells seashells by the seashore" "To be or not to be that is the question"', 10);

test_block(2, <<'IN', <<'OUT');
A123,           B_456,      C789,           D@1,        E123
electronics,    restaurant, electronics,    pharmacy,   grocery
true,           false,      true,           true,       true
IN
true,           false,      true,           false,      true
OUT

test_block(2, <<'IN', <<'OUT');
Z_9,        AB_12,          G01,        X99,            test
pharmacy,   electronics,    grocery,    electronics,    unknown
true,       true,           false,      true,           true
IN
true,       true,           false,      true,           false
OUT

test_block(2, <<'IN', <<'OUT');
_123,       123,            ,               Coupon_A,   Alpha
restaurant, electronics,    electronics,    pharmacy,   grocery
true,       true,           false,          true,       true
IN
true,       true,           false,          true,       true
OUT

test_block(2, <<'IN', <<'OUT');
ITEM_1,         ITEM_2,         ITEM_3,     ITEM_4
electronics,    electronics,    grocery,    grocery
true,           true,           true,       true
IN
true,           true,           true,       true
OUT

test_block(2, <<'IN', <<'OUT');
CAFE_X,     ELEC_100,       FOOD_1,     DRUG_A,     ELEC_99
restaurant, electronics,    grocery,    pharmacy,   electronics
true,       true,           true,       true,       false
IN
true,       true,           true,       true,       false
OUT

done_testing;
