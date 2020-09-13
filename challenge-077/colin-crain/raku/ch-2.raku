#!/usr/bin/env perl6
# 
#
#       lonely_ex.pl
#
#         TASK #2 › Lonely X
#         Submitted by: Mohammad S Anwar
#         You are given m x n character matrix consists of O and X only.
# 
#         Write a script to count the total number of X surrounded by O only.
#         Print 0 if none found.
# 
#         Example 1:
#         Input: [ O O X ]
#                [ X O O ]
#                [ X O O ]
# 
#         Output: 1 as there is only one X at the first row last column
#         surrounded by only O.
#         Example 2:
#         Input: [ O O X O ]
#                [ X O O O ]
#                [ X O O X ]
#                [ O X O O ]
# 
#         Output: 2
# 
#             a) First  X found at Row 1 Col 3.
# 
#             b) Second X found at Row 3 Col 4.
#
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (*@input) ;

## in
@input = qw<OOXO XOOO XOOX OXOO> if @input ~~ Empty;            
our @matrix = @input.map({.comb});
my @lonely;

## work
for ^@matrix[0].elems X ^@matrix.elems -> ($x, $y) {
    if (@matrix[$y][$x] eq 'X' and is_lonely($x, $y)) {
        @lonely.push: ($x, $y);
    }
}

## out
.join(' ').say for @matrix;
say '';
for @lonely -> @point {
    my ($col, $row) = @point.map({$_+1});
    say "the X at column → $col, row down ↓ $row is lonely";
}

sub is_lonely {
    my ($x, $y) = @_;
    
    for ((-1,0,1) X (-1,0,1)).grep( * !eqv (0,0)) -> $offset {
        next if 0 > any ($x + $offset[0]) | ($y + $offset[1]);
        next if ! defined @matrix[ $y + $offset[1] ][ $x + $offset[0] ];
        return 0 if @matrix[ $y + $offset[1] ][ $x + $offset[0] ] eq 'X';  
    }
    return 1;    
}
