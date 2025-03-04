#!/usr/bin/env perl

use v5.35;
use Test2::Bundle::More;
use List::Util qw/ sum /;

sub groupDigitSum{
    my ($digits, $integer) = @_;
    while( $integer < length($digits)){
        $digits = join '', map {sum(split //)} $digits =~ m/(\w{1,$integer})/g;
    }
    return $digits;
}

is(groupDigitSum("111122333", 3), '359', 'Example 1');
is(groupDigitSum("1222312", 2), '76', 'Example 2');
is(groupDigitSum("100012121001", 4), '162', 'Example 3');

done_testing();
