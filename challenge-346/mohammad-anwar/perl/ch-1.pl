#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { str => '(()())',        exp => 6 },
    { str => ')()())',        exp => 4 },
    { str => '((()))()(((()', exp => 8 },
    { str => '))))((()(',     exp => 2 },
    { str => '()(()',         exp => 2 },
);

foreach (@examples) {
    is(valid_longest_parenthesis($_->{str}), $_->{exp});
}

done_testing;

sub valid_longest_parenthesis {
    my $s       = shift;
    my @stack   = (-1);
    my $max_len = 0;

    for my $i (0 .. length($s) - 1) {
        if (substr($s, $i, 1) eq "(") {
            push @stack, $i;
        } else {
            pop @stack;
            if (@stack) {
                $max_len = $max_len > ($i - $stack[-1])
                          ? $max_len : ($i - $stack[-1]);
            } else {
                push @stack, $i;  # New starting point
            }
        }
    }

    return $max_len;
}
