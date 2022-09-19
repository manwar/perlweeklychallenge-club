#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  ∅ ≡ ∩ ≢
use v6.d;

use lib $?FILE.IO.parent;
use Prime::Factor;
use Expect-achilles;
use Test;

=begin comment
Challenge 169 Task 2: Achilles Numbers Submitted by: Mohammad S Anwar

Generate the first 20 Achilles Numbers.
An Achilles number is a number that is powerful but not a perfect power.

A positive integer n is powerful if, for every prime factor p of n, p^2 is also a divisor.

A number is a perfect power if it has any integer roots (square root, cube root, etc.).

Each prime factor of an Achilles number occurs twice or more and all the
primes factors cannot be separated and grouped to produce any root.

=end comment

    # Ignore the number's factors, instead check the factors of
    # the factors' counts.  Any one count indicates not powerful.
    # A non-empty set-diff of the counts' factors indicates there
    # are no integer roots.

my constant @achilles = gather for 72 … ∞ {
    my @ct-per-factor = .&prime-factors.Bag.values;
    next if @ct-per-factor.any == 1
                or
            ∅ ≢ [∩] @ct-per-factor.map: *.&prime-factors.Set;
    .&take;
}

constant TEST = True;

if TEST {
    my $t-count = @expect-achilles.elems;
    $t-count = 300;
    plan $t-count;

    for 0 .. $t-count - 1 {
        is @achilles[$_], @expect-achilles[$_]; # , "$_ @expect-achilles[$_]"; 
    }
    done-testing;
    exit;
}

sub MAIN( Int $n = 20 ) {
    my $out = "Output\n " ~ @achilles[0 .. $n-1].join( ', ', :skip-empty);
    say $out;
}

