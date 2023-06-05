#!usr/bin/perl
use v5.36;

# Challenge 219 - 1 - Sorted Squares

sortedSquares(-2, -1,  0, 3, 4);     # (0, 1, 4, 9, 16)
sortedSquares( 5, -4, -1, 3, 6);     # (1, 9, 16, 25, 36)

sub sortedSquares(@array)
{
    say join ', ', sort map{$_ * $_ } @array
}