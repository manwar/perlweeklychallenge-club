#!/bin/env raku

# The Weekly Challenge 255
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

# Task 1, Odd Character
pwc-test './ch-1.raku', <Perl Preel>,     'e',  'Odd Character: "Perl", "Preel"     => "e"';
pwc-test './ch-1.raku', <Weekly Weeakly>, 'a',  'Odd Character: "Weekly", "Weeakly" => "a"';
pwc-test './ch-1.raku', <Box Boxy>,       'y',  'Odd Character: "Box", "Boxy"       => "y"';

# Task 2, Most Frequent Word
pwc-test './ch-2.raku',
    "Joe hit a ball, the hit ball flew far after it was hit.",
    'hit',
    'ball',
    'Most Frequent Word: "Joe hit a ball, the hit ball flew far after it was hit." => ball';
pwc-test './ch-2.raku',
    "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
    'the',
    'Perl',
    'Most Frequent Word: "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge." => Perl';

done-testing;
