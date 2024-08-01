#!/usr/bin/env perl

use v5.40;

use Test::More;

sub do_it ($str) {
    $str =~ s/\|.*?\|//sg;
    return scalar(() = $str =~ /\*/g);
}

is do_it("p|*e*rl|w**e|*ekly|"), 2, 'Example 1';
is do_it("perl"), 0, 'Example 2';
is do_it("th|ewe|e**|k|l***ych|alleng|e"), 5, 'Example 3';

done_testing;
