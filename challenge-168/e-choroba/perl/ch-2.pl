#!/usr/bin/perl
use warnings;
use strict;

use Math::Prime::Util qw{ factor is_prime };

sub home_prime {
    my ($i) = @_;
    my $concat = join "", sort { $a <=> $b } factor($i);

    return $concat if is_prime($concat);

    return home_prime($concat)
}

use Test::More tests => 1;
is home_prime(10), 773;
