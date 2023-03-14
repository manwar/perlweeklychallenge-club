#!/usr/bin/perl -s

use v5.16;
use warnings;
use List::Gen;
use Math::Prime::Util qw(prev_prime next_prime);
use experimental 'signatures';

our $weak;

die <<EOS unless @ARGV == 1;
usage: $0 [-weak] N

-weak
    print "weak" primes instead of "strong" ones

N
    print the first N primes from the selected category

EOS


### Input and Output

gen_sw_primes(!$weak)->say(shift);


### Implementation

sub gen_sw_primes ($strong) {
    iterate(sub {next_prime($_)})
    ->from(3)
    ->filter(sub {!$strong ^ ($_ > (prev_prime($_) + next_prime($_)) / 2)});	
}
