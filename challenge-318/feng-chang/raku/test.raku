#!/bin/env raku

# The Weekly Challenge 318
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

# Task 1, Group Position
pwc-test './ch-1.raku', 'abccccd',        'cccc',         'Group Position: aaccccd        => cccc';
pwc-test './ch-1.raku', 'aaabcddddeefff', 'aaa dddd fff', 'Group Position: aaabcddddeefff => aaa dddd fff';
pwc-test './ch-1.raku', 'abcdd',          '',             'Group Position: abcdd          => ""';

# Task 2, Reverse Equals
pwc-test './ch-2.raku', '3,2,1,4', '1,2,3,4', 'True',  'Reverse Equals: 3,2,1,4 1,2,3,4 => true';
pwc-test './ch-2.raku', '1,3,4',   '4,1,3',   'False', 'Reverse Equals: 1,3,4   4,1,3   => false';
pwc-test './ch-2.raku', '2',       '2',       'True',  'Reverse Equals: 2       2       => true';
