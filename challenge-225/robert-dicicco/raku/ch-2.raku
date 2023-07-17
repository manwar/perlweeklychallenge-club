#!/usr/bin/env raku
=begin comment
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-11
Challenge 225 Task 2 Left Right Sum Diff ( Raku )
---------------------------------------
=end comment

use v6;

#my @array = (1, 2, 3, 4, 5);
my @array = (10,4,8,3);
my @left = ();
my @right = ();
my @left_right_sum_diff = ();

sub ltr(@array) {
    my $sum = 0;
    @left.push(0);
    for 0 .. @array.elems - 2 -> $i {
        $sum += @array[$i];
        @left.push($sum);
    }
}

sub rtl(@array) {
    my $sum = 0;
    @right.push(0);
    my $i = @array.elems - 1;
    while $i > 0 {
        $sum += @array[$i];
        push @right, $sum;
        $i--;
    }
}

say "Input:  \@ints = ",@array;
ltr(@array);
say "\t\@left = ",@left;
rtl(@array);
@right = @right.reverse;
say "\t\@right = ",@right;

my $i = 0;
while $i < @array.elems {
    @left_right_sum_diff.push(abs(@left[$i] - @right[$i]));
    $i++;
}

say "\tOutput: @left_right_sum_diff = ",@left_right_sum_diff;

=begin comment
---------------------------------------
Sraku LRSD.rk
SAMPLE OUTPUT
Input:  @ints = [1 2 3 4 5]
        @left = [0 1 3 6 10]
        @right = [14 12 9 5 0]
        Output: @left_right_sum_diff = [14 11 6 1 10]

raku LRSD.rk

Input:  @ints = [10 4 8 3]
        @left = [0 10 14 22]
        @right = [15 11 3 0]
        Output: @left_right_sum_diff = [15 1 11 22]
---------------------------------------
=end comment


