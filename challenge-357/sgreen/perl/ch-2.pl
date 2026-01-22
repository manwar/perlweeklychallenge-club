#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use Number::Fraction;

sub main ($int) {
    my @fractions = ();
    foreach my $n ( 1 .. $int ) {
        foreach my $d ( 1 .. $int ) {
            my $fraction = Number::Fraction->new( $n, $d );
            push @fractions, $fraction
              if not grep { $_ == $fraction } @fractions;
        }
    }

    my @sorted_fractions = sort { $a <=> $b } @fractions;
    say join( ", ", map( { "$_->{num}/$_->{den}" } @sorted_fractions ) );
}


main($ARGV[0]);