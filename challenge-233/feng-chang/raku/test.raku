#!/bin/env raku

# The Weekly Challenge 233
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Similar Words
pwc-test
    './ch-1.raku', |<aba aabb abcd bac aabc>,
    "aba aabb\nbac aabc",
    'Similar Words: ("aba", "aabb", "abcd", "bac", "aabc") => "aba aabb\nbac aabc"';
pwc-test
    './ch-1.raku', |<aabb ab ba>,
    "aabb ab\naabb ba\nab ba",
    'Similar Words: ("aabb", "ab", "ba") => "aabb ab\naabb ba\nab ba"';
pwc-test
    './ch-1.raku', |<nba cba dba>,
    "",
    'Similar Words: ("nba", "cba", "dba") => ""';

# Task 2, Frequency Sort
    pwc-test './ch-2.raku', |<1 1 2 2 2 3>,             '3,1,1,2,2,2',          'Frequency Sort: 1,1,2,2,2,3          => 3,1,1,2,2,2';
    pwc-test './ch-2.raku', |<2 3 1 3 2>,               '1,3,3,2,2',            'Frequency Sort: 2,3,1,3,2            => 1,3,3,2,2';
    pwc-test './ch-2.raku', |<-- -1 1 -6 4 5 -6 1 4 1>, '5,-1,4,4,-6,-6,1,1,1', 'Frequency Sort: -1,1,-6,4,5,-6,1,4,1 => 5,-1,4,4,-6,-6,1,1,1';

done-testing;
