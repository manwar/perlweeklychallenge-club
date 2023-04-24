#!usr/bin/perl
use v5.36;

# Challenge 213 - 1 - Fun Sort
# You are given a list of positive integers.
# Write a script to sort the all even integers first then all odds in ascending order.

funSort(1,2,3,4,5,6);       # Output: (2,4,6,1,3,5)
funSort(1,2);               #   2,1
funSort(1);                 # 1
funSort(78,22,11,14,25,76); 

sub funSort(@input)
{
    @input   = sort @input;
    my @odd  = grep{ ($_% 2) != 0} @input;
    my @even = grep{ ($_% 2) == 0} @input;
    say join(',', @even, @odd );
    
    # in one line
    # say join(',',  (grep{ ($_% 2) == 0} sort @input), grep{ ($_% 2) != 0} @input);
}