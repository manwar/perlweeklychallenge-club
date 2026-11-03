#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub string_difference(@words) {
    my %h;
    for my $i (0 .. $#words) {
        my $s = "";
        for my $j (1 .. length($words[$i]) - 1) {
            $s .= ord((split //, $words[$i])[$j]) -
                ord((split //, $words[$i])[ $j - 1 ]);
        }
        undef $h{$s}{ $words[$i] };
    }
    return (keys %{ (grep 1 == keys %$_, values %h)[0] })[0]
}

use Test::More tests => 5;

is string_difference('ab', 'bc', 'cd', 'zy'), 'zy', 'Example 1';
is string_difference('cba', 'fed', 'azy'), 'azy', 'Example 2';
is string_difference('pop', 'ada', 'beb', 'cfc'), 'pop', 'Example 3';
is string_difference('aaaa', 'zzzz', 'mmmm', 'aaba'), 'aaba', 'Example 4';
is string_difference('aceg', 'bdfh', 'cegi', 'azbz'), 'azbz', 'Example 5';
