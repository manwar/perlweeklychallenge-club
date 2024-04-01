#!/bin/env raku

# The Weekly Challenge 239
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

# Task 1, Same String
pwc-test './ch-1.raku', 'ab c',    'a bc',  'True',  'Same String: "ab c",    "a bc"  => True';
pwc-test './ch-1.raku', 'ab c',    'ac b',  'False', 'Same String: "ab c",    "ac b"  => False';
pwc-test './ch-1.raku', 'ab cd e', 'abcde', 'True',  'Same String: "ab cd e", "abcde" => True';

# Task 2, Consistent Strings
pwc-test './ch-2.raku', |<ad bd aaab baa badab ab>,      2,
    'Consistent Strings: @str = ("ad", "bd", "aaab", "baa", "badab"), $allowed = "ab"               => 2';
pwc-test './ch-2.raku', |<a b c ab ac bc abc abc>,       7,
    'Consistent Strings: @str = ("a", "b", "c", "ab", "ac", "bc", "abc"), $allowed = "abc"          => 7';
pwc-test './ch-2.raku', |<cc acd b ba bac bad ac d cad>, 4,
    'Consistent Strings: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d"), $allowed = "cad" => 4';

done-testing;
