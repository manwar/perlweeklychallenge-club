#!/bin/env perl6

# Challenge: Write a script to print all possible series of 3 positive numbers, where in each series
# at least one of the number is even and sum of the three numbers is always 12. For example, 3,4,5.
# NOTE: For the purpose of this solution, 0 is considered a positive, even number.

say "Combinations: ", my @c = (^9).combinations(3).grep: { .sum == 12 && (.first: * %% 2).defined };
say "Permutations: ", my @p = gather { my @x; for @c -> $l { @x = $l.permutations; .take for @x } };
