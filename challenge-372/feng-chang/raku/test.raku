#!/bin/env raku

# The Weekly Challenge 372
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

# Task 1, Rearrange Spaces
pwc-test './ch-1.raku', '  challenge  ',               "'challenge    '",               'Rearrange Spaces: "  challenge  "               => "challenge    "';
pwc-test './ch-1.raku', 'coding  is  fun',             "'coding  is  fun'",             'Rearrange Spaces: "coding  is  fun"             => "coding  is  fun"';
pwc-test './ch-1.raku', 'a b c  d',                    "'a b c d '",                    'Rearrange Spaces: "a b c  d"                    => "a b c d "';
pwc-test './ch-1.raku', '  team      pwc  ',           "'team          pwc'",           'Rearrange Spaces: "  team      pwc  "           => "team          pwc"';
pwc-test './ch-1.raku', '   the  weekly  challenge  ', "'the    weekly    challenge '", 'Rearrange Spaces: "   the  weekly  challenge  " => "the    weekly    challenge "';

# Task 2, Largest Substring
pwc-test './ch-2.raku', 'aaaaa',    3, 'Largest Substring: "aaaaa"    => 3';
pwc-test './ch-2.raku', 'abcdeba',  5, 'Largest Substring: "abcdeba"  => 5';
pwc-test './ch-2.raku', 'abbc',     0, 'Largest Substring: "abbc"     => 0';
pwc-test './ch-2.raku', 'abcaacbc', 4, 'Largest Substring: "abcaacbc" => 4';
pwc-test './ch-2.raku', 'laptop',   2, 'Largest Substring: "laptop"   => 2';
