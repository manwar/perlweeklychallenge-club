#!/bin/env raku

use Test;

# The Weekly Challenge 214

# Task 1, Rank Score
my $p = run <./ch-1.raku 1 2 4 3 5>, :out;
is $p.out.slurp(:close).chomp, '5, 4, S, B, G', 'Rank Score: 1,2,4,3,5 => 5, 4, S, B, G';

$p = run <./ch-1.raku 8 5 6 7 4>, :out;
is $p.out.slurp(:close).chomp, 'G, 4, B, S, 5', 'Rank Score: 8,5,6,7,4 => G, 4, B, S, 5';

$p = run <./ch-1.raku 3 5 4 2>, :out;
is $p.out.slurp(:close).chomp, 'B, G, S, 4', 'Rank Score: 3,5,4,2 => B, G, S, 4';

$p = run <./ch-1.raku 2 5 2 1 7 5 1>, :out;
is $p.out.slurp(:close).chomp, '4, S, 4, 6, G, S, 6', 'Rank Score: 2,5,2,1,7,5,1 => 4, S, 4, 6, G, S, 6';

# Task 2, Collect Points
$p = run <./ch-2.raku 2 4 3 3 3 4 5 4 2>, :out;
is $p.out.slurp(:close).chomp, 23, 'Collect Points:  2,4,3,3,3,4,5,4,2 => 23';

$p = run <./ch-2.raku 1 2 2 2 2 1>, :out;
is $p.out.slurp(:close).chomp, 20, 'Collect Points:  1,2,2,2,2,1 => 20';

$p = run <./ch-2.raku 1>, :out;
is $p.out.slurp(:close).chomp, 1, 'Collect Points:  1 => 1';

$p = run <./ch-2.raku 2 2 2 1 1 2 2 2>, :out;
is $p.out.slurp(:close).chomp, 40, 'Collect Points:  2,2,2,1,1,2,2,2 => 40';

# Task 2, Collect Points, Solution 2
$p = run <./ch-2a.raku 2 4 3 3 3 4 5 4 2>, :out;
is $p.out.slurp(:close).chomp, 23, 'Collect Points, Solution 2:  2,4,3,3,3,4,5,4,2 => 23';

$p = run <./ch-2a.raku 1 2 2 2 2 1>, :out;
is $p.out.slurp(:close).chomp, 20, 'Collect Points, Solution 2:  1,2,2,2,2,1 => 20';

$p = run <./ch-2a.raku 1>, :out;
is $p.out.slurp(:close).chomp, 1, 'Collect Points, Solution 2:  1 => 1';

$p = run <./ch-2a.raku 2 2 2 1 1 2 2 2>, :out;
is $p.out.slurp(:close).chomp, 40, 'Collect Points, Solution 2:  2,2,2,1,1,2,2,2 => 40';

done-testing;
