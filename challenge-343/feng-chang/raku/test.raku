#!/bin/env raku

# The Weekly Challenge 343
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

# Task 1, Zero Friend
pwc-test './ch-1.raku', <4 2 -1 3 -2>,       1, 'Zero Friend: (4,2,-1,3,-2)    => 1';
pwc-test './ch-1.raku', <-- -5 5 -3 3 -1 1>, 1, 'Zero Friend: (-5,5,-3,3,-1,1) => 1';
pwc-test './ch-1.raku', <7 -3 0 2 -8>,       0, 'Zero Friend: (7,-3,0,2,-8)    => 0';
pwc-test './ch-1.raku', <-- -2 -5 -1 -8>,    1, 'Zero Friend: (-2,-5,-1,-8)    => 1';
pwc-test './ch-1.raku', <-- -2 2 -4 4 -1 1>, 1, 'Zero Friend: (-2,2,-4,4,-1,1) => 1';

# Task 2, Champion Team
pwc-test './ch-2.raku', '[0,1,1],[0,0,1],[0,0,0]',                                     'Team 0',         'Champion Team: [0,1,1],[0,0,1],[0,0,0]                                     => "Team 0"';
pwc-test './ch-2.raku', '[0,1,0,0],[0,0,0,0],[1,1,0,0],[1,1,1,0]',                     'Team 3',         'Champion Team: [0,1,0,0],[0,0,0,0],[1,1,0,0],[1,1,1,0]                     => "Team 3"';
pwc-test './ch-2.raku', '[0,1,0,1],[0,0,1,1],[1,0,0,0],[0,0,1,0]',                     'Team 0',         'Champion Team: [0,1,0,1],[0,0,1,1],[1,0,0,0],[0,0,1,0]                     => "Team 0"';
pwc-test './ch-2.raku', '[0,1,1],[0,0,0],[0,1,0]',                                     'Team 0',         'Champion Team: [0,1,1],[0,0,0],[0,1,0]                                     => "Team 0"';
pwc-test './ch-2.raku', '[0,0,0,0,0],[1,0,0,0,0],[1,1,0,1,1],[1,1,0,0,0],[1,1,0,1,0]', 'Team 2',         'Champion Team: [0,0,0,0,0],[1,0,0,0,0],[1,1,0,1,1],[1,1,0,0,0],[1,1,0,1,0] => "Team 2"';
pwc-test './ch-2.raku', '[0,1,0],[0,0,1],[1,0,0]',                                     'Team 0,1,2 tie', 'Champion Team: [0,1,0],[0,0,1],[1,0,0]                                     => "Team 0,1,2 tie"';
