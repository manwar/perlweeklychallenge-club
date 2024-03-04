#!/bin/env raku

# The Weekly Challenge 242
use Test;

sub pwc-in-test(Str:D $script, Str:D $f where *.IO.e, $expect, $assertion, Bool :$deeply? = False) {
    my $p = run $script, :in, :out;
    $p.in.put($f.IO.slurp);
    $p.in.close;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Missing Members
pwc-in-test './ch-1.raku', 'data-1-1.txt',
    'Array One: Array Two: [1 3] [4 6]',
    'Missing Members: @arr1 = (1, 2, 3), @arr2 = (2, 4, 6) => [1 3] [4 6]';
pwc-in-test './ch-1.raku', 'data-1-2.txt',
    'Array One: Array Two: [3] []',
    'Missing Members: @arr1 = (1, 2, 3, 3), @arr2 = (1, 1, 2, 2) => [3] []';

# Task 2, Flip Matrix
pwc-in-test './ch-2.raku', 'data-2-1.txt',
    '[[1 0 0] [0 1 0] [1 1 1]]',
    'Flip Matrix: [[1 1 0] [1 0 1] [0 0 0]]                 => [[1 0 0] [0 1 0] [1 1 1]]';
pwc-in-test './ch-2.raku', 'data-2-2.txt',
    '[[1 1 0 0] [0 1 1 0] [0 0 0 1] [1 0 1 0]]',
    'Flip Matrix: [[1 1 0 0] [1 0 0 1] [0 1 1 1] [1 0 1 0]] => [[1 1 0 0] [0 1 1 0] [0 0 0 1] [1 0 1 0]]';

done-testing;
