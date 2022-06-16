#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent;

use Test;
use Prime::Factor;
use Expect-brilliant;

=begin comment
Task 1: Brilliant Numbers Submitted by: Mohammad S Anwar

Generate the first 20 Brilliant Numbers, which are numbers with
exactly two prime factors which have the same number of digits.

An example: 24289 = 107 x 227

Expected output:
Output
4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, \
247, 253, 289, 299
=end comment

constant TEST = False;

my constant @brilliant = gather for 1 … ∞ {
    next if $_ > 14 and $_ %% 2 or .is-prime;
    my @factor = .&prime-factors;
    if @factor.elems == 2 and @factor[0].chars == @factor[1].chars {
        .&take;
    }
}

if TEST {
    my $elems = @expect-brilliant.elems;
    plan $elems;
    for 0 ..^ $elems {
        is @brilliant[$_], @expect-brilliant[$_], $_ + 1  ~ " @brilliant[$_]";
    }
    done-testing;
    exit;
}

sub MAIN( Int $n = 20 ) {
    my $out = "\nOutput\n" ~ @brilliant[ 0.. $n - 1 ].join: ', ';
    say $out;
    die "Not as expected." if $n == 20 
            and $out ne
          "\nOutput\n4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, "
        ~ "169, 187, 209, 221, 247, 253, 289, 299";
}

