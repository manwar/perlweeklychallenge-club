#!/usr/bin/env perl

use v5.26;
use strict;
use warnings;

use Math::Prime::Util qw( prime_iterator is_prime );

my @matches;
my $it = prime_iterator();

while ( @matches < 10 ) {
    my $prime = $it->();
    my $plus_six = $prime + 6;
    push @matches, "$prime, $plus_six" if is_prime( $plus_six );
}

say join( "\n", @matches );
