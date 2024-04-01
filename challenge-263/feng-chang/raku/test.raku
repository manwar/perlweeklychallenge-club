#!/bin/env raku

# The Weekly Challenge 263
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

# Task 1, Target Index
pwc-test './ch-1.raku', <1 5 3 2 4 2>, 2, '(1 2)', 'Target Index: @ints = (1,5,3,2,4,2), $k=2 => (1, 2)';
pwc-test './ch-1.raku', <1 2 4 3 5>,   6, '()',    'Target Index: @ints = (1,2,4,3,5),   $k=6 => ()';
pwc-test './ch-1.raku', <5 3 2 4 2 1>, 4, '(4)',   'Target Index: @ints = (5,3,2,4,2,1), $k=4 => (4)';

# Task 2, Merge Items
pwc-test './ch-2.raku', '[1,1],[2,1],[3,2]', '[2,2],[1,3]', '[[1, 4], [2, 3], [3, 2]]',
    'Merge Items: $items1 = [[1,1],[2,1],[3,2]],       $items2 = [[2,2],[1,3]] => [[1,4],[2,3],[3,2]]';
pwc-test './ch-2.raku', '[1,2],[2,3],[1,3],[3,2]', '[3,1],[1,3]', '[[1, 8], [2, 3], [3, 3]]',
    'Merge Items: $items1 = [[1,2],[2,3],[1,3],[3,2]], $items2 = [[3,1],[1,3]] => [[1,8],[2,3],[3,3]]';
pwc-test './ch-2.raku', '[1,1],[2,2],[3,3]', '[2,3],[2,4]', '[[1, 1], [2, 9], [3, 3]]',
    'Merge Items: $items1 = [[1,1],[2,2],[3,3]],       $items2 = [[2,3],[2,4]] => [[1, 1], [2, 9], [3, 3]]';

pwc-test './ch-2a.raku', '[1,1],[2,1],[3,2]', '[2,2],[1,3]', '[[1, 4], [2, 3], [3, 2]]',
    'Merge Items: $items1 = [[1,1],[2,1],[3,2]],       $items2 = [[2,2],[1,3]] => [[1,4],[2,3],[3,2]]';
pwc-test './ch-2a.raku', '[1,2],[2,3],[1,3],[3,2]', '[3,1],[1,3]', '[[1, 8], [2, 3], [3, 3]]',
    'Merge Items: $items1 = [[1,2],[2,3],[1,3],[3,2]], $items2 = [[3,1],[1,3]] => [[1,8],[2,3],[3,3]]';
pwc-test './ch-2a.raku', '[1,1],[2,2],[3,3]', '[2,3],[2,4]', '[[1, 1], [2, 9], [3, 3]]',
    'Merge Items: $items1 = [[1,1],[2,2],[3,3]],       $items2 = [[2,3],[2,4]] => [[1, 1], [2, 9], [3, 3]]';
