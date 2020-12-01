#!/bin/env raku

=begin Challenge
087, Task #1

You are given an unsorted array of integers @N.
Write a script to find the longest consecutive sequence. Print 0 if none sequence found.

Example 1:
    Input:  @N = (100, 4, 50, 3, 2)
    Output: (2, 3, 4)

Example 2:
    Input:  @N = (20, 30, 10, 40, 50)
    Output: 0

Example 3:
    Input:  @N = (20, 19, 9, 11, 10)
    Output: (9, 10, 11)

=end Challenge

sub MAIN(*@N) {
    @N .= sort;
    my \宽 = @N.elems - 1;

    my @a = (0..宽-1 X 1..宽)
        .grep({ $_[1] > $_[0] })
        .grep({ $_[1] - $_[0] == @N[$_[1]] - @N[$_[0]] });
    put do {
        @a.elems > 0 ?? @a.max({ $_[1] - $_[0] }).map({ @N[$^a..$^b] }) !! 0;
    }
}
