#!/bin/env raku

# The Weekly Challenge 307
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

# Task 1, Check Order
pwc-test './ch-1.raku', <5 2 4 3 1>, '0 2 3 4', 'Check Order: 5,2,4,3,1 => 0,2,3,4';
pwc-test './ch-1.raku', <1 2 1 1 3>, '1 3',     'Check Order: 1,2,1,1,3 => 1,3';
pwc-test './ch-1.raku', <3 1 3 2 3>, '0 1 3',   'Check Order: 3,1,3,2,3 => 0,1,3';

# Task 2, Find Anagrams
pwc-test './ch-2.raku', <acca dog god perl repl>, 3, 'Find Anagrams: acca,dog,god,perl,repl => 3';
pwc-test './ch-2.raku', <abba baba aabb ab ab>,   2, 'Find Anagrams: abba,baba,aabb,ab,ab   => 2';
