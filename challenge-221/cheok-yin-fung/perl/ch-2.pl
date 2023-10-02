# The Weekly Challenge 221
# Task 2 Arithmetic Subsequence
# Brute-force approach, just hope the number of lines is minimalist
use v5.30.0;
use warnings;
use List::Util qw/all sum uniqint/;
use List::MoreUtils qw/slide/;

sub as {
    my @arr = @_;
    return 1 if scalar @arr == 1;
    my $len_of_longest_as = 2;
    for my $i (reverse 7..2**($#arr+1)-1) {
        my $l = length sprintf("%0b", $i);
        my @bin = split "", "0" x ($#arr+1-$l).sprintf("%0b", $i);
        next if sum (@bin) < $len_of_longest_as;
        my @n_arr = map {$arr[$_]} grep {$bin[$_]} (0..$#arr);
        my @diffs = slide {$a-$b} @n_arr;
        $len_of_longest_as = sum (@bin) if scalar (uniqint @diffs) == 1;
    }
    return $len_of_longest_as;
}

use Test::More tests=> 3;
ok as(9, 4, 7, 2, 10) == 3;
ok as(3, 6, 9, 12) == 4;
ok as(20, 1, 15, 3, 10, 5, 8) == 4;
