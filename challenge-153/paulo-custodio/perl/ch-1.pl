#!/usr/bin/env perl

# Challenge 153
#
# TASK #1 › Left Factorials
# Submitted by: Mohammad S Anwar
# Write a script to compute Left Factorials of 1 to 10. Please refer
# OEIS A003422 for more information.
#
# Expected Output:
# 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114

use Modern::Perl;

my @out;
for (1..10) {
    push @out, left_fact($_);
}
say join(", ", @out);


sub fact {
    my($n) = @_;
    if ($n < 2) {
        return 1;
    }
    else {
        return $n * fact($n-1);
    }
}

sub left_fact {
    my($n) = @_;
    my $sum = 0;
    for my $k (0..$n-1) {
        $sum += fact($k);
    }
    return $sum;
}
