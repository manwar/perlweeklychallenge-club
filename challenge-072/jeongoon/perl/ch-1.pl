#!/usr/bin/env perl
# -*- Mode: cperl; cperl-indent-level:4 tab-width: 8; indent-tabs-mode: nil -*-
# -*- coding: utf-8 -*-

use strict; use warnings;
use bigint;

my $N = $ARGV[0];

if ( $N < 1 ) {
    warn "Invalid: N < 1: sould be >= 1: using 1";
    $N = 1;
}

if ( not defined $N ) {
    warn "use default value: 10.\n";
    $N = 10;
}

sub f {
    return 1 if $_[0] == 1; # $_[0] < 1 is filtered above
    return $_[0] * f ($_[0]-1);
}

sub zero_length::f_and_count ($) {
    # make a (big) number
    # take only zeros from the end
    # and return length of it
    ( my $n = f( $_[0] ) ) =~ m/(0+$)/;
    length $1 || 0
}

sub zero_length::reduce ($) {
    my $z = 0; # put this line here for better indention in CPerl Mode

=pod

 => Every 10 ( 2 * 5 ) makes a zero digit in the end.
 A. if find the even number count it
 B: if find the the number divisible by 5
    then count how many times divisible by 5

 But even numbers exsists plenty which more than the numbers divisible by 5
 ** sorry I cannot prove it mathematically but..

   1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
 A   1   2   3   4    5     6     7     8     9    10    11    12
 B         1          2              3              4              6

 graphically it shows it is right.

    if A.count > B.count then (which seems correct)
        sum of B.count would be how many zeros in the end of the number

=cut

    map {
        my $i = 0;
        ( ++$z, ++$i ) while not $_ % ( 5**($i+1) );
        $N == $_? $z :();
    } 1 .. $N;
}

print "Counted:   ", zero_length::f_and_count( $N ), $/;
print "Caculated: ", zero_length::reduce( $N ), $/;
