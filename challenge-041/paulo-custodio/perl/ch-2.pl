#!/usr/bin/env perl

# Challenge 041
#
# TASK #2
# Write a script to display first 20 Leonardo Numbers. Please checkout wiki
# page for more information.
# For example:
#
# L(0) = 1
# L(1) = 1
# L(2) = L(0) + L(1) + 1 = 3
# L(3) = L(1) + L(2) + 1 = 5
# and so on.

use Modern::Perl;

my @out;
for (0..19) {
    push @out, leonardo($_);
}
say join(", ", @out);


sub leonardo {
    my($n) = @_;
    if ($n < 2) {
        return 1;
    }
    else {
        return leonardo($n-1)+leonardo($n-2)+1;
    }
}
