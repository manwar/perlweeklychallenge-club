#!/usr/bin/raku
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v6.d;

use Test;

class TestCase {
    has Str:D $.str is required is readonly;
    has Bool:D $.expected is required is readonly;
}

my constant @TEST_SEQUENCES = (
    # The test strings from the problem
    TestCase.new(str => '17893729974', expected => True),
    TestCase.new(str => '4137 8947 1175 5904', expected => True),
    TestCase.new(str => '4137 8974 1175 5904', expected => False),

    # Let's start simple...
    TestCase.new(str => '00', expected => True),
    TestCase.new(str => '01', expected => False),
    TestCase.new(str => '05', expected => False),
    TestCase.new(str => '18', expected => True),
    TestCase.new(str => '19', expected => False),
    TestCase.new(str => '11', expected => False),
    TestCase.new(str => '59', expected => True),
    TestCase.new(str => '50', expected => False),
    TestCase.new(str => '67', expected => True),
    TestCase.new(str => '66', expected => False),

    # Now make sure we can ignore extraneous characters
    TestCase.new(str => ' ?23a#2 :)', expected => True),
    TestCase.new(str => ' ?32a#2 :)', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k0', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k1', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k2', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k3', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k4', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k5', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k6', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k7', expected => True),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k8', expected => False),
    TestCase.new(str => 'a0b1c2d3e4f5g6h7i8j9k9', expected => False),
);

class LuhnState {
    has Int:D $.sum is required is readonly;
    has Bool:D $.double is required is readonly;

    method default(LuhnState:U:) returns LuhnState:D {
        self.new(sum => 0, double => True)
    }

    method update(Int:D $digit) returns LuhnState:D {
        my Int:D $value = $.double ?? $digit * 2 !! $digit;
        my Int:D $sum = $.sum + ($value > 9 ?? $value - 9 !! $value);
        self.new(:$sum, double => !$.double)
    }
};

sub luhn-check(Str:D $str) returns Bool:D
{
    my Int:D @digits = $str.flip.comb(/<[0 .. 9]>/).map: *.Int;
    die 'No digits at all' unless @digits;
    my Int:D $cksum = @digits.shift;

    my LuhnState:D $state = reduce { $^acc.update: $^digit }, LuhnState.default, |@digits;
    return (($state.sum + $cksum) % 10) == 0
}

plan @TEST_SEQUENCES.elems;

for @TEST_SEQUENCES {
    is $_.expected, luhn-check $_.str;
}
