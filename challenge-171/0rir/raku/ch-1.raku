#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin comment
Task 1: Abundant Number     Submitted by: Mohammad S Anwar

Generate the first 20 Abundant Odd Numbers. An abundant number is
defined as a number n for which the sum of proper divisors > n.
Odd means odd.

945 is the first Abundant Odd Number because the proper divisor summed
are greater than 945:
1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975
=end comment

sub proper-divisors (Int $n where $n > 0 --> Array ) {
    # after the Rosetta code
    my @result = 1 if $n > 1;
    ( 2 .. $n.sqrt.Int ).map: -> $d {
        unless $n % $d {
            @result.push: $d;
            my $y = $n div $d;
            @result.push: $y if $y != $d
        }
    }
    @result;
}

constant @odd-abundant = gather {
    my Int $i = 943;
    loop {
        $i += 2;
        next if $i.is-prime;
        if $i < [+] proper-divisors( $i) {
            take $i;
            next;
        }
    }
}

say @odd-abundant[ 0 .. 19].join( ', ');
exit;

