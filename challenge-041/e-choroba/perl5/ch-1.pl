#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use Math::Prime::Util qw{ factor is_prime };

sub is_attractive {
    my ($n) = @_;
    is_prime(factor($n))
}

say for grep is_attractive($_), 1 .. 50;


