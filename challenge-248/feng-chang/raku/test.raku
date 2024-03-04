#!/bin/env raku

# The Weekly Challenge 248
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

# Task 1, Shortest Distance
pwc-test './ch-1.raku',
    'loveleetcode', 'e',
    '(3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0)',
    'Shortest Distance: loveleetcode, e => (3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0)';
pwc-test './ch-1.raku',
    'aaab', 'b',
    '(3, 2, 1, 0)',
    'Shortest Distance: aaab, b         => (3, 2, 1, 0)';

# Task 2, Submatrix Sum
pwc-test './ch-2.raku',
    '[1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12]',
    '[[14, 18, 22], [30, 34, 38]]',
    'Submatrix Sum: [[1,  2,  3,  4], [5,  6,  7,  8], [9, 10, 11, 12]]      => [[14, 18, 22], [30, 34, 38]]';
pwc-test './ch-2.raku',
    '[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]',
    '[[2, 1, 0], [1, 2, 1], [0, 1, 2]]',
    'Submatrix Sum: [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]] => [[2, 1, 0], [1, 2, 1], [0, 1, 2]]';

done-testing;
