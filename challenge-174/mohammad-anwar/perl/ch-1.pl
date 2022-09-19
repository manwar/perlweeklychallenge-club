#!/usr/bin/perl

=head1

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #1: Disarium Numbers

    Write a script to generate first 19 Disarium Numbers.

=cut

use v5.36;
use Test2::V0;

is disarium_numbers(19),
   [ 0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798 ];

done_testing;

#
#
# METHODS

sub is_disarium_number($n) {
    my @n = split //,$n;
    my $s = 0;
    $s += $n[$_] ** ($_ + 1) for (0 .. @n-1);

    return ($s == $n);
}

sub disarium_numbers($n) {
    die "ERROR: Missing number.\n"    unless defined $n;
    die "ERROR: Invalid number $n.\n" if $n < 0;

    my $i  = 0;
    my @dn = ();
    while (@dn < $n) {
        push @dn, $i if is_disarium_number $i;
        $i++;
    }

    return \@dn;
}
