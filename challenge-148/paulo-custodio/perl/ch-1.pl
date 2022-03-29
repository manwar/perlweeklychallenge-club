#!/usr/bin/env perl

# Challenge 148
#
# TASK #1 › Eban Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate all Eban Numbers <= 100.
#
# An Eban number is a number that has no letter ‘e’ in it when the number
# is spelled in English (American or British).
#
# Example
# 2, 4, 6, 30, 32 are the first 5 Eban numbers.

use Modern::Perl;
use Lingua::EN::Numbers qw(num2en);

my @out;
for my $n (1..100) {
    push @out, $n if is_eban($n);
}
say join(", ", @out);


sub is_eban {
    my($n) = @_;
    my $en = num2en($n);
    return $en !~ /e/;
}
