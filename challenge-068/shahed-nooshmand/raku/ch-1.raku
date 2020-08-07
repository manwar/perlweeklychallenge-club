#!/usr/bin/env raku

my $M = 3;
my $N = 3;

my @matrix = [1, 0, 1],
         [1, 1, 1],
         [1, 0, 1];
my @result = [1 xx $N] xx $M;

@result[$_] = [0 xx $N] if 0 ∈ @matrix[$_] for ^$M;
@result[*; $_] = [0 xx $M] if 0 ∈ @matrix[*; $_] for ^$N;

.put for @result;
