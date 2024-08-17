#!/bin/env raku

# The Weekly Challenge 280
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

# Task 1, Twice Appearance
pwc-test './ch-1.raku', 'acbddbca', 'd', 'Twice Appearance: acbddbca => d';
pwc-test './ch-1.raku', 'abccd',    'c', 'Twice Appearance: abccd    => c';
pwc-test './ch-1.raku', 'abcdabbb', 'a', 'Twice Appearance: abcdabbb => a';

# Task 2, Count Asterisks
pwc-test './ch-2.raku', 'p|*e*rl|w**e|*ekly|',           2, 'Count Asterisks: "p|*e*rl|w**e|*ekly|"           => 2';
pwc-test './ch-2.raku', 'perl',                          0, 'Count Asterisks: "perl"                          => 0';
pwc-test './ch-2.raku', 'th|ewe|e**|k|l***ych|alleng|e', 5, 'Count Asterisks: "th|ewe|e**|k|l***ych|alleng|e" => 5';
