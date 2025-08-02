#!/bin/env raku

# The Weekly Challenge 257
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

# Task 1, Smaller than Current
pwc-test './ch-1.raku', <5 2 1 6>, '2, 1, 0, 3', 'Smaller than Current: 5, 2, 1, 6 => 2, 1, 0, 3';
pwc-test './ch-1.raku', <1 2 0 3>, '1, 2, 0, 3', 'Smaller than Current: 1, 2, 0, 3 => 1, 2, 0, 3';
pwc-test './ch-1.raku', <0 1>,     '0, 1',       'Smaller than Current: 0, 1       => 0, 1'; 
pwc-test './ch-1.raku', <9 4 9 2>, '2, 1, 2, 0', 'Smaller than Current: 9, 4, 9, 2 => 2, 1, 2, 0';

# Task 2, Reduced Row Echelon
pwc-test './ch-2.raku', '[1,0,0],[0,0,0],[0,1,0]', 0, 'Reduced Row Echelon: [1,0,0],[0,0,0],[0,1,0] => 0';
pwc-test './ch-2.raku', '[1,0,0],[0,1,0],[0,0,0]', 1, 'Reduced Row Echelon: [1,0,0],[0,1,0],[0,0,0] => 1';
pwc-test './ch-2.raku', '[1,0,0],[0,2,0],[0,0,0]', 0, 'Reduced Row Echelon: [1,0,0],[0,2,0],[0,0,0] => 0';
pwc-test './ch-2.raku', '[1,0,0,1],[0,1,0,2],[0,0,1,3]', 1, 'Reduced Row Echelon: [1,0,0,1],[0,1,0,2],[0,0,1,3] => 1';
pwc-test './ch-2.raku', '[0,1,-2,0,1],[0,0,0,1,3],[0,0,0,0,0],[0,0,0,0,0]', 1, 'Reduced Row Echelon: [0,1,-2,0,1],[0,0,0,1,3],[0,0,0,0,0],[0,0,0,0,0] => 1';
pwc-test './ch-2.raku', '[1,0,0,4],[0,1,0,7],[0,0,1,-1]', 1, 'Reduced Row Echelon: [1,0,0,4],[0,1,0,7],[0,0,1,-1] => 1';
pwc-test './ch-2.raku', '[0,1,-2,0,1],[0,0,0,0,0],[0,0,0,1,3],[0,0,0,0,0]', 0, 'Reduced Row Echelon: [0,1,-2,0,1],[0,0,0,0,0],[0,0,0,1,3],[0,0,0,0,0] => 0';
pwc-test './ch-2.raku', '[0,1,0],[1,0,0],[0,0,0]', 0, 'Reduced Row Echelon: [0,1,0],[1,0,0],[0,0,0] => 0';
pwc-test './ch-2.raku', '[4,0,0,0],[0,1,0,7],[0,0,1,-1]', 0, 'Reduced Row Echelon: [4,0,0,0],[0,1,0,7],[0,0,1,-1] => 0';
