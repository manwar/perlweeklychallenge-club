#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
Task 1: Disarium Numbers    Submitted by: Mohammad S Anwar
Generate the first 19 Disarium Numbers.  A disarium is an integer where
the sum of each digit raised to the power of its position left to right,
is equal to the number.

518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518

Hind sights:
Did strings as obvious.
A fat-log function probably has a place in the world. Rakudo's log( $n, 10)
is good to about 13 digits.
My elimination by last digit could be tuned.
Using math with Ints instead of arrays seems a possible optimization.

=end comment

my @d = 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598, 1306, 1676, 2427, 2646798, 12157692622039623539;

my constant @disarium = lazy gather do {

    take $_ for 1 … 9, 89, 135, 175;
    for 500 … ∞  -> $n {
        next if $n % 10 < 6;
        my $d = 0;
        my @a = $n.split: '', :skip-empty; 
        for  reverse( 0..@a.end)  {
            $d += @a[$_]**($_+1);
            last if $d > $n; # or 0 == $_;
        }
        take $n if $n == $d;
    }
};

my $t = now;
say "The first 18 disarium numbers are:";
print @disarium[0];
print ", @disarium[$_]" for 1 .. 17;
say "\nThat took: ", now - $t, ' seconds.';

