#!/bin/env raku

# The Weekly Challenge 273
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

# Task 1, Percentage of Character
pwc-test './ch-1.raku', <perl e>,      25, 'Percentage of Character: $str = "perl",      $char = "e" => 25';
pwc-test './ch-1.raku', <java a>,      50, 'Percentage of Character: $str = "java",      $char = "a" => 50';
pwc-test './ch-1.raku', <python m>,     0, 'Percentage of Character: $str = "phthon",    $char = "m" => 0';
pwc-test './ch-1.raku', <ada a>,       67, 'Percentage of Character: $str = "ada",       $char = "a" => 67';
pwc-test './ch-1.raku', <ballerina l>, 22, 'Percentage of Character: $str = "ballerina", $char = "l" => 22';
pwc-test './ch-1.raku', <analitik k>,  13, 'Percentage of Character: $str = "analitik",  $char = "k" => 13';

# Task 2, B After A
pwc-test './ch-2.raku', 'aabb', 'True',  'B After A: aabb => true';
pwc-test './ch-2.raku', 'abab', 'False', 'B After A: abab => false';
pwc-test './ch-2.raku', 'aaa',  'False', 'B After A: aaa  => false';
pwc-test './ch-2.raku', 'bbb',  'True',  'B After A: bbb  => true';
