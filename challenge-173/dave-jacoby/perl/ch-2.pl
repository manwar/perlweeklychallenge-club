#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

# this looks like a job for iteration

use List::Util qw{ product };
use Math::BigInt;

# Did I mention that I like Math::BigInt?

my @n = map { Math::BigInt->new($_) } ( 2, 3 );

while ( scalar @n < 10 ) {
    my $x = Math::BigInt->bone();;
    push @n, 1 + product @n ;
}
say join "\n  ", '', @n;
