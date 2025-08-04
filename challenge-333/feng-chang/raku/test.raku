#!/bin/env raku

# The Weekly Challenge 333
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

# Task 1, Straight Line
pwc-test './ch-1.raku', '[2,1],[2,3],[2,5]',  'True',  'Straight Line: [2,1],[2,3],[2,5]  => true';
pwc-test './ch-1.raku', '[1,4],[3,4],[10,4]', 'True',  'Straight Line: [1,4],[3,4],[10,4] => true';
pwc-test './ch-1.raku', '[0,0],[1,1],[2,3]',  'False', 'Straight Line: [0,0],[1,1],[2,3]  => false';
pwc-test './ch-1.raku', '[1,1],[1,1],[1,1]',  'True',  'Straight Line: [1,1],[1,1],[1,1]  => true';
pwc-test './ch-1.raku', '[1000000,1000000],[2000000,2000000],[3000000,3000000]', 'True',
         'Straight Line: [1000000,1000000],[2000000,2000000],[3000000,3000000] => true';

# Task 2, Duplicate Zeros
pwc-test './ch-2.raku', <1 0 2 3 0 4 5 0>, '1 0 0 2 3 0 0 4', 'Duplicate Zeros: 1,0,2,3,0,4,5,0 => 1,0,0,2,3,0,0,4';
pwc-test './ch-2.raku', <1 2 3>,           '1 2 3',           'Duplicate Zeros: 1,2,3           => 1,2,3';
pwc-test './ch-2.raku', <1 2 3 0>,         '1 2 3 0',         'Duplicate Zeros: 1,2,3,0         => 1,2,3,0';
pwc-test './ch-2.raku', <0 0 1 2>,         '0 0 0 0',         'Duplicate Zeros: 0,0,1,2         => 0,0,0,0';
pwc-test './ch-2.raku', <1 2 0 3 4>,       '1 2 0 0 3',       'Duplicate Zeros: 1,2,0,3,4       => 1,2,0,0,3';
