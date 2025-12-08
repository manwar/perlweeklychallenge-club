#!/bin/env raku

# The Weekly Challenge 350
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Good Substrings
pwc-test './ch-1.raku', 'abcaefg', 5, 'Good Substrings: abcaefg => 5';
pwc-test './ch-1.raku', 'xyzzabc', 3, 'Good Substrings: xyzzabc => 3';
pwc-test './ch-1.raku', 'aababc',  1, 'Good Substrings: aababc  => 1';
pwc-test './ch-1.raku', 'qwerty',  4, 'Good Substrings: qwerty  => 4';
pwc-test './ch-1.raku', 'zzzaaa',  0, 'Good Substrings: zzzaaa  => 0';

# Task 2, Shuffle Pairs
pwc-test './ch-2.raku', <1 1000 1>,                 0, 'Shuffle Pairs: $from=1,         $to=1000,      $count=1 =>  0';
pwc-test './ch-2.raku', <1500 2500 1>,              3, 'Shuffle Pairs: $from=1500,      $to=2500,      $count=1 =>  3';
pwc-test './ch-2.raku', <1_000_000 1_500_000 5>,    2, 'Shuffle Pairs: $from=1_000_000, $to=1_500_000, $count=5 =>  2';
pwc-test './ch-2.raku', <13_427_000 14_100_000 2>, 11, 'Shuffle Pairs: $from=13_427_000,$to=14_100_000,$count=2 => 11';
pwc-test './ch-2.raku', <1030 1130 1>,              2, 'Shuffle Pairs: $from=1030,      $to=1130,      $count=1 =>  2';
