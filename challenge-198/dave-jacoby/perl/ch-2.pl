#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };
use Algorithm::Permute;

my @examples = ( 10, 15, 1, 25 );

for my $e (@examples) {
    my $out = prime_count($e);
    say <<"END";
    Input:  \$n = $e
    Output: $out
END
}

# 1 is not a prime, but 2 is, but the regex in is_prime accepts 1, so
# we start on 2 and go to the given max
# grep ( is_prime($_) ) gives only the list of primes 
# scalar gives us the count, which is what we want
sub prime_count ( $e ) {
    return scalar grep { is_prime($_) } 2 .. $e;
}

# https://catonmat.net/perl-regex-that-matches-composite-numbers
sub is_prime ( $n ) { ( '1' x $n ) !~ /\A(11+?)\1+\z/ }
