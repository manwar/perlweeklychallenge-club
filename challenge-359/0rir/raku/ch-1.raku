#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
359-1: Digital Root             Submitted by: Mohammad Sajid Anwar

You are given a positive integer, $int.

Write a function that calculates the additive persistence of a positive integer and also return the digital root.

Digital root is the recursive sum of all digits in a number until a single digit is obtained.

Additive persistence is the number of times you need to sum the digits to reach a single digit.

=end comment

my @Test =
#    seed       persistence     digital-root
    38,             2,          2,
    7,              0,          7,
    999,            2,          9,
    1999999999,     3,          1,
    101010,         1,          3,
;
plan  @Test;

class PerDig {
    has Int:D $.seed         is required;
    has Int:D $.persistence  is required;
    has Int:D $.digital-root is required;

    method from-Int( Int:D $a is copy where 0 < * ) {
        my $seed = $a;
        my $p = 0;
        while $a.chars > 1 {
           $a = sum $a.comb;
           ++$p;
        }
        PerDig.Mu::new( :$seed, :persistence($p), :digital-root($a))
    }
    multi method weekly-challenge-fmt( $seed-->Str:D) {
          "Input \$int = $seed\n"
        ~ "Output: Persistence  = $.persistence\n"
        ~ "        Digital Root = $.digital-root";
    }
    multi method weekly-challenge-fmt( -->Str:D) {    # ?able to have $.seed
        self.weekly-challenge-fmt( $.seed );
    }
}#end class PerDig 

sub task( Any(Int) $a -->PerDig) {
    PerDig.from-Int( $a) 
}

for @Test -> $in, $persist, $dig-root {
    my $per-dig = task $in;
    my $dit;
    is $dit = $per-dig.seed,$in,                " $dit <-input captured $in";
    is $dit = $per-dig.persistence, $persist,   " $dit <-persistence    $in";
    is $dit = $per-dig.digital-root, $dig-root, " $dit <-digital root   $in";
}
done-testing;

my $int = 1999999999;
say "\n" ~ task($int).weekly-challenge-fmt;
