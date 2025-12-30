#!/bin/env raku

# The Weekly Challenge 354
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

# Task 1, Min Abs Diff
pwc-test './ch-1.raku', <4 2 1 3>, '[1, 2], [2, 3], [3, 4]',  'Min Abs Diff: 4,2,1,3      => [1, 2], [2, 3], [3, 4]';
pwc-test './ch-1.raku', <10 100 20 30>, '[10, 20], [20, 30]', 'Min Abs Diff: 10,100,20,30 => [10, 20], [20, 30]';
pwc-test './ch-1.raku', <-- -5 -2 0 3>, '[-2, 0]',            'Min Abs Diff: -5,-2,0,3    => [-2, 0]';
pwc-test './ch-1.raku', <8 1 15 3>, '[1, 3]',                 'Min Abs Diff: 8,1,15,3     => [1, 3]';
pwc-test './ch-1.raku', <12 5 9 1 15>, '[9, 12], [12, 15]',   'Min Abs Diff: 12,5,9,1,15  => [9, 12], [12, 15]';

# Task 2, Shift Grid
pwc-test './ch-2.raku',
    '@matrix=[1,2,3],[4,5,6],[7,8,9]; $k=1',
    '[9, 1, 2], [3, 4, 5], [6, 7, 8]',
    'Shift Grid: @matrix=[1,2,3],[4,5,6],[7,8,9]; $k=1 => [9, 1, 2], [3, 4, 5], [6, 7, 8]';
pwc-test './ch-2.raku',
    '@matrix=[10,20],[30,40]; $k=1',
    '[40, 10], [20, 30]',
    'Shift Grid: @matrix=[10,20],[30,40]; $k=1         => [40, 10], [20, 30]';
pwc-test './ch-2.raku',
    '@matrix=[1,2],[3,4],[5,6]; $k=1',
    '[6, 1], [2, 3], [4, 5]',
    'Shift Grid: @matrix=[1,2],[3,4],[5,6]; $k=1       => [6, 1], [2, 3], [4, 5]';
pwc-test './ch-2.raku',
    '@matrix=[1,2,3],[4,5,6]; $k=5',
    '[2, 3, 4], [5, 6, 1]',
    'Shift Grid: @matrix=[1,2,3],[4,5,6]; $k=5         => [2, 3, 4], [5, 6, 1]';
pwc-test './ch-2.raku',
    '@matrix=[1,2,3,4]; $k=1',
    '[4, 1, 2, 3]',
    'Shift Grid: @matrix=[1,2,3,4]; $k=1               => [4, 1, 2, 3]';
