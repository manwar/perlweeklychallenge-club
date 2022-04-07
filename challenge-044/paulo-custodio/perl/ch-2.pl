#!/usr/bin/env perl

# Challenge 044
#
# TASK #2
# Make it $200
# You have only $1 left at the start of the week. You have been given an
# opportunity to make it $200. The rule is simple with every move you can either
# double what you have or add another $1. Write a script to help you get $200
# with the smallest number of moves.

use Modern::Perl;
no warnings 'recursion';

my $min = join("+", (1)x200);
find_min("1", 1);
say $min;

sub find_min {
    my($str, $num) = @_;
    if ($num > 200) {
    }
    elsif ($num == 200) {
        if (length($str) < length($min)) {
            $min = $str;
        }
    }
    else {
        find_min("$str*2", $num*2);
        find_min("$str+1", $num+1);
    }
}
