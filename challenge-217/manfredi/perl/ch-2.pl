#!/usr/bin/env perl

use v5.36;

say "challenge-217-task2";

# Task 2: Max Number
# You are given a list of positive integers.
# Write a script to concatenate the integers to form the highest possible value.

# Example 1
# Input: @list = (1, 23)
# Output: 231

# Example 2
# Input: @list = (10, 3, 2)
# Output: 3210

# Example 3
# Input: @list = (31, 2, 4, 10)
# Output: 431210

sub max_number {
    my @list = @{+shift};
    $" = ', ';
    say "Input: \@list = (@list)";
    my $out = join "", sort { $b cmp $a } @list;  
    say "Output: $out\n";
}

while (<DATA>) {
    chomp;
    my @list = split /\s*,\s*/;
    max_number(\@list);
}


__DATA__
1, 23
10, 3 ,2
31, 2 , 4, 10
5, 11, 4, 1, 2
1, 10
