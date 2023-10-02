#!usr/bin/perl
use v5.38;

use builtin 'indexed';
use List::MoreUtils 'uniq';
no warnings 'experimental';

# Challenge 235 - 1 - Remove One
# You are given an array of integers.
# Write a script to find out if removing ONLY one integer makes it strictly increasing order.


say rem1(0, 2, 9, 4, 6);    # Output: true
say rem1(5, 1, 3, 2);       # Output: false
say rem1(2, 2, 3);          # Output: true
say rem1(2, 2, 3, 4);       # Output: true
say rem1(2, 2, 3, 0);       # Output: false since it is not strictly increasing


sub rem1(@input)
{
    
    foreach my($index, $elem) ( indexed @input)
    {
        my @temp = @input;
        
        splice(@temp, $index, 1);

        my @sorted = uniq sort  @temp;      # somehow sort uniq is not working hmm (´。＿。｀)

        return "true"       if( "@sorted"  eq "@temp");

    }
    
    return "false";
}