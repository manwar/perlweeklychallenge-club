#!usr/bin/perl
use v5.36;

# Challenge 230 - 1 - Separate Digits
# You are given an array of positive integers.

# Write a script to separate the given array into single digits.
separate(1, 34, 5, 6);
separate(1, 24, 51, 60);


sub separate(@array)
{
    my @result;
    foreach my $elem (@array)
    {
        push(@result, split('', $elem));
    }
    
    say join(', ', @result);
}