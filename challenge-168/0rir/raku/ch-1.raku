#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

use lib $?FILE.IO.parent(2).add("lib");
use Test;
=begin comment

Task 1: Perrin Prime    Submitted by: Roger Bell_West
The Perrin sequence is defined to start with [3, 0, 2]; thereafter term N
is the sum of terms N-2 and N-3.

A Perrin prime is a prime number in the Perrin sequence.
Calculate the first 13 Perrin Primes.

=end comment

my @exp-perrin = 3, 0, 2, 3, 2, 5, 5, 7, 10, 12, 17, 22, 29, 39;
my @exp-per-rime = 2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977;

my Int @Perrin = 3, 0, 2, { $_ = @_[*-3] + @_[*-2] } … ∞;

my @Perrin-prime = lazy gather {
    my %seen;
    for 2 … ∞  -> $i {      # skip out of order dupes
        if @Perrin[$i].is-prime { 
            take @Perrin[$i] unless %seen{@Perrin[$i]};
            %seen{@Perrin[$i]} = True;
        }
    }
};
say 'f(13) = [' ~ @Perrin-prime[0..12].join( ',') ~ ']';
say '';

plan 2;
is @Perrin[0..13], @exp-perrin, 'Perrin';
is @Perrin-prime[0..12] , @exp-per-rime, '@Perrin-prime[0..12] ';
done-testing;


