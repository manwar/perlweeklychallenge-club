#!/bin/env raku

# The Weekly Challenge 253
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

# Task 1, Split Strings
pwc-test './ch-1.raku',
    |<. one.two.three four.five six>,
    'one two three four five six',
    'Split Strings: @words = ("one.two.three", "four.five", "six"), $separator = "." => "one","two","three","four","five","six"';
pwc-test './ch-1.raku',
    |<$ $perl$$ $$raku$>,
    'perl raku',
    'Split Strings: @words = ("$perl$$", "$$raku$"),                $separator = "$" => "perl","raku"';

# Task 2, Weakest Row
pwc-test './ch-2.raku',
    '[1,1,0,0,0],[1,1,1,1,0],[1,0,0,0,0],[1,1,0,0,0],[1,1,1,1,1]',
    '2, 0, 3, 1, 4',
    'Weakest Row: [[1,1,0,0,0],[1,1,1,1,0],[1,0,0,0,0],[1,1,0,0,0],[1,1,1,1,1]] => (2, 0, 3, 1, 4)';
pwc-test './ch-2.raku',
    '[1,0,0,0],[1,1,1,1],[1,0,0,0],[1,0,0,0]',
    '0, 2, 3, 1',
    'Weakest Row: [[1,0,0,0],[1,1,1,1],[1,0,0,0],[1,0,0,0]]                     => (0, 2, 3, 1)';

done-testing;
