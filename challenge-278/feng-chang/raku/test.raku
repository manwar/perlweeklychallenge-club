#!/bin/env raku

# The Weekly Challenge 278
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

# Task 1, Sort String
pwc-test './ch-1.raku', <and2 Raku3 cousins5 Perl1 are4>, 'Perl and Raku are cousins',
    'Sort String: "and2 Raku3 cousins5 Perl1 are4"                   => "Perl and Raku are cousins"';
pwc-test './ch-1.raku', <guest6 Python1 most4 the3 popular5 is2 language7>, 'Python is the most popular guest language',
    'Sort String: "guest6 Python1 most4 the3 popular5 is2 language7" => "Python is the most popular guest language"';
pwc-test './ch-1.raku', <Challenge3 The1 Weekly2>, 'The Weekly Challenge',
    'Sort String: "Challenge3 The1 Weekly2"                          => "The Weekly Challenge"';
pwc-test './ch-1.raku', <j10 i9 h8 g7 f6 e5 d4 c3 b2 a1>, 'a b c d e f g h i j',
    'Sort String: "j10 i9 h8 g7 f6 e5 d4 c3 b2 a1"                   => "a b c d e f g h i j"';

# Task 2, Reverse Word
pwc-test './ch-2.raku', 'challenge',   'e', 'acehllnge',   'Reverse Word: $str="challenge",   $char="e" => "acehllnge"';
pwc-test './ch-2.raku', 'programming', 'a', 'agoprrmming', 'Reverse Word: $str="programming", $char="a" => "agoprrmming"';
pwc-test './ch-2.raku', 'champion',    'b', 'champion',    'Reverse Word: $str="champion",    $char="b" => "champion"';
