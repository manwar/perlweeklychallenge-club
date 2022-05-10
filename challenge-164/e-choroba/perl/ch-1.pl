#!/usr/bin/perl
use warnings;
use strict;

use Math::Prime::Util qw{ forprimes is_prime };

sub prime_palindrome {
    my @pp;
    forprimes { push @pp, $_ if $_ == reverse } 999;
    return \@pp
}

use Test::More tests => 1;
is_deeply prime_palindrome(),
    [grep $_ eq reverse && is_prime($_), 2 .. 999];
