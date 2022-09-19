#!/usr/bin/perl -s

use v5.16;
use warnings;
use Math::Prime::Util 'prime_iterator';
use List::Util 'reductions';

die <<EOS unless @ARGV;
usage: $0 N

N   
    Print the first N primorials.

EOS


# Math::Prime::Util has 'primorial', but as the *sequence* of the first
# N primorials is requested in this task, another approach seems to be
# more useful: Build the sequence of the first N-1 primes' product.

main: {
    my $pi = prime_iterator();
    say for reductions {$a * $b} 1, map $pi->(), 2 .. shift;
}
