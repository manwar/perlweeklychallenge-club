#!/bin/env raku

# The Weekly Challenge 151
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Binary Tree Depth
pwc-test './ch-1.raku', '',                  0, 'Binary Tree Depth: ""                  => 0';
pwc-test './ch-1.raku', '1',                 1, 'Binary Tree Depth: "1"                 => 1';
pwc-test './ch-1.raku', '1 | 2',             2, 'Binary Tree Depth: "1 | 2"             => 2';
pwc-test './ch-1.raku', '1 | 2 3',           2, 'Binary Tree Depth: "1 | 2 3"           => 2';
pwc-test './ch-1.raku', '1 | 2 3 | 4',       2, 'Binary Tree Depth: "1 | 2 3 | 4"       => 2';
pwc-test './ch-1.raku', '1 | 2 3 | 4 5',     2, 'Binary Tree Depth: "1 | 2 3 | 4 5"     => 2';
pwc-test './ch-1.raku', '1 | 2 3 | 4 5 6',   3, 'Binary Tree Depth: "1 | 2 3 | 4 5 6"   => 3';
pwc-test './ch-1.raku', '1 | 2 3 | 4 5 * 6', 3, 'Binary Tree Depth: "1 | 2 3 | 4 5 * 6" => 3';

pwc-test './ch-1.raku', '1 | 2 3 | 4 * * 5 | * 6', 3, 'Binary Tree Depth: "1 | 2 3 | 4 * * 5 | * 6" => 3';

# Task 2, Rob The House
pwc-test './ch-2.raku', |<2 4 5>,       7,  'Rob The House: (2, 4, 5) => 7';
pwc-test './ch-2.raku', |<4 2 3 6 5 3>, 13, 'Rob The House: (4, 2, 3, 6, 5, 3) => 13';

done-testing;
