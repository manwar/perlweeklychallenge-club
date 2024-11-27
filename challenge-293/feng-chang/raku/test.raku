#!/bin/env raku

# The Weekly Challenge 293
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

# Task 1, Similar Dominos
pwc-test './ch-1.raku', '[1,3],[3,1],[2,4],[6,8]',       2, 'Similar Dominos: [1,3],[3,1],[2,4],[6,8]       => 2';
pwc-test './ch-1.raku', '[1,2],[2,1],[1,1],[1,2],[2,2]', 3, 'Similar Dominos: [1,2],[2,1],[1,1],[1,2],[2,2] => 3';

# Task 2, Boomerang
pwc-test './ch-2.raku', '[1,1],[2,3],[3,2]', 'True',  'Boomerang: [1,1],[2,3],[3,2] => true';
pwc-test './ch-2.raku', '[1,1],[2,2],[3,3]', 'False', 'Boomerang: [1,1],[2,2],[3,3] => false';
pwc-test './ch-2.raku', '[1,1],[1,2],[2,3]', 'True',  'Boomerang: [1,1],[1,2],[2,3] => true';
pwc-test './ch-2.raku', '[1,1],[1,2],[1,3]', 'False', 'Boomerang: [1,1],[1,2],[1,3] => false';
pwc-test './ch-2.raku', '[1,1],[2,1],[3,1]', 'False', 'Boomerang: [1,1],[2,1],[3,1] => false';
pwc-test './ch-2.raku', '[0,0],[2,3],[4,5]', 'True',  'Boomerang: [0,0],[2,3],[4,5] => true';
