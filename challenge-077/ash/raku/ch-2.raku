#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/

# Comments: https://andrewshitov.com/2020/09/08/lonely-x-the-weekly-challenge-77-task-2/

my @matrix =
    < O O X >,
    < X O O >,
    < X O O >; # square matrix

# my @matrix =
#     < O O X O >,
#     < X O O O >,
#     < X O O X >,
#     < O X O O >;

my @neighbours = ([X] (-1, 0, 1) xx 2).grep(*.all != 0);

for ^@matrix X ^@matrix -> @coord {
    next if @matrix[@coord[0]][@coord[1]] eq 'O';

    @coord.put if all((@neighbours.map(* <<+>> @coord)).grep(0 <= *.all <= @matrix.end).map({        
        @matrix[$_[0]][$_[1]] eq 'O';
    }));
}

# Output:
# $ raku ch-2.raku 
# 0 2

# Or:
# $ raku ch-2.raku 
# 0 2
# 2 3
