#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use Number::Fraction;

sub get_parent {
    my $f = shift;

    # 1/1 and -1/1 are orphened fractions.
    return undef if not defined $f or abs($f) == 1;

    # Deal with postive fractions for now
    my $new_n = abs( $f->{num} );
    my $new_d = $f->{den};

    if ( $new_n > $new_d ) {    # f > 1
        $new_n = $new_n - $new_d;
    }
    else {
        $new_d = $new_d - $new_n;
    }

    # Turn the fraction back to negative if needed
    $new_n = 0 - $new_n if $f < 0;

    return Number::Fraction->new( $new_n, $new_d );
}

sub f {
    # Fraction's to_string method won't show the denominator when it is 1
    my $f = shift;
    return $f ? "'" . $f->{num} . '/' . $f->{den} . "'" : 'None';
}

sub main {

    my $fract       = Number::Fraction->new(shift);
    my $parent      = get_parent($fract);
    my $grandparent = get_parent($parent);

    say 'parent = ', f($parent), ' and grandparent is ', f($grandparent);
}

main(@ARGV);
