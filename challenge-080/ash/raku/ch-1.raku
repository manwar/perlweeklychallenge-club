#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080/

use Test;

is missing-n(5, 2, -2, 0), 1;
is missing-n(1, 8, -1), 2;
is missing-n(2, 0, -1), 1;

# If the smallest missing is the biggest :-)
is missing-n(5, 2, 3, 1, -2, 0), 4;
is missing-n(5, 2, 3, 1, 4, -2, 0), 6;

sub missing-n(*@n is copy) {
    @n.=grep: * > 0;

    my $missing = max(@n);
    for 1 .. $missing + 1 {
        $missing = $_ and last unless @n.grep($_);
    }

    return $missing;
}
