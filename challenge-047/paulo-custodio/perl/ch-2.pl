#!/usr/bin/env perl

# Challenge 047
#
# TASK #2
# Gapful Number
# Write a script to print first 20 Gapful Numbers greater than or equal to 100.
# Please check out the page for more information about Gapful Numbers.

use Modern::Perl;

my @out;
my $n = 100;
while (@out < 20) {
    push @out, $n if is_gapfull($n);
    $n++;
}
say join(", ", @out);

sub is_gapfull {
    my($n) = @_;
    my $div = substr($n,0,1).substr($n,-1,1);
    return ($n % $div) == 0;
}
