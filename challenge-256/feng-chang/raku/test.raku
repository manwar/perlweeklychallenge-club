#!/bin/env raku

# The Weekly Challenge 256
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

# Task 1, Maximum Pairs
pwc-test './ch-1.raku', <ab de ed bc>,       1, 'Maximum Pairs: "ab", "de", "ed", "bc"             => 1';
pwc-test './ch-1.raku', <aa ba cd ed>,       0, 'Maximum Pairs: "aa", "ba", "cd", "ed"             => 0';
pwc-test './ch-1.raku', <uv qp st vu mn pq>, 2, 'Maximum Pairs: "uv", "qp", "st", "vu", "mn", "pq" => 2';

# Task 2, Merge Strings
pwc-test './ch-2.raku', <abcd 1234>, 'a1b2c3d4', 'Merge Strings: "abcd", "1234" => a1b2c3d4';
pwc-test './ch-2.raku', <abc 12345>, 'a1b2c345', 'Merge Strings: "abc", "12345" => a1b2c345';
pwc-test './ch-2.raku', <abcde 123>, 'a1b2c3de', 'Merge Strings: "abcde", "123" => a1b2c3de';
