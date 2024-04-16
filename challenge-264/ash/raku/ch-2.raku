# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-264/

# Test run:
# $ raku ch-2.raku
# [0 4 1 3 2]

my @source = 0, 1, 2, 3, 4;
my @indices = 0, 1, 2, 2, 1; # output: [0 4 1 3 2]

# my @source = 1, 2, 3, 4, 0;
# my @indices = 0, 1, 2, 3, 0; # output: [0 1 2 3 4]

# my @source = 1;
# my @indices = 0; # output: [1]

my @target;
for ^@indices -> $index {
    @target.splice: @indices[$index], 0, @source[$index];

}

say @target;
