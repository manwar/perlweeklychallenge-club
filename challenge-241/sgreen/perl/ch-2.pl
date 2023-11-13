#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub count_primes ($i) {
    # Calculate the number of primes that make up the specified number
    my $primes = 0;
    my $count  = 2;

    while ( $i > 1 ) {
        if ( $i % $count == 0 ) {
            $primes++;
            $i /= $count;
        }
        else {
            $count++;
        }
    }

    return $primes;
}

sub main (@ints) {
    my %primes = ( map { $_, count_primes($_) } @ints );

    # Sort the integers in ascender order, and then by the steps required
    my @sorted_ints = sort { $primes{$a} <=> $primes{$b} || $a <=> $b } @ints;

    say '(', join( ', ', @sorted_ints ), ')';

}

main(@ARGV);