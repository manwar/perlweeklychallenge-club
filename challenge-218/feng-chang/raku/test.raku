#!/bin/env raku

# The Weekly Challenge 218
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Maximum Product
pwc-test './ch-1.raku', '--', |<3 1 2>,            6, 'Maximum Product: 3 1 2          =>   6';
pwc-test './ch-1.raku', '--', |<4 1 3 2>,         24, 'Maximum Product: 4 1 3 2        =>  24';
pwc-test './ch-1.raku', '--', |<-1 0 1 3 1>,       3, 'Maximum Product: -1 0 1 3 1     =>   3';
pwc-test './ch-1.raku', '--', |<-8 2 -9 0 -4 3>, 216, 'Maximum Product: -8 2 -9 0 -4 3 => 216';

# Task 2, Matrix Score
pwc-test './ch-2.raku', '[[0,0,1,1], [1,0,1,0], [1,1,0,0]]',
    39,
    'Matrix Score: [[0,0,1,1], [1,0,1,0], [1,1,0,0]]  => 39';
pwc-test './ch-2.raku', '[[0]]', 1, 'Matrix Score: [[0]] => 1';

done-testing;
