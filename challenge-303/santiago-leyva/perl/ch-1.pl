=begin
You are given a list (3 or more) of positive integers, @ints.

Write a script to return all even 3-digits integers that can be formed using the integers in the given list.

Example 1
Input: @ints = (2, 1, 3, 0)
Output: (102, 120, 130, 132, 210, 230, 302, 310, 312, 320)
Example 2
Input: @ints = (2, 2, 8, 8, 2)
Output: (222, 228, 282, 288, 822, 828, 882)
=cut

use strict;
#use warnings;
use List::Util 'sum';
use Data::Dumper;

my @nums = ([2, 1, 3, 0],[2, 2, 8, 8, 2]);

foreach(@nums){
    my @arr = @$_;
    my @result = findCombinations(\@arr);
    print "For ",join(" ",@arr)," the combinations are value is -> ",join(" ",@result)," \n";
}

sub findCombinations {


    my ($digits) = @_;
    
    # Count the frequency of each digit in the digits list
    my %cnt;
    $cnt{$_}++ for @$digits;
    
    my @ans;
    
    # Iterate through all 3-digit even numbers between 100 and 999
    for my $x (100..999) {
        next unless $x % 2 == 0;  # Skip odd numbers
        
        my %cnt1;
        my $y = $x;
        
        # Count the frequency of digits in the current number x
        while ($y) {
            my $digit = $y % 10;
            $cnt1{$digit}++;
            $y = int($y / 10);
        }
        
        # Check if we can form this number from the available digits
        my $valid = 1;
        for my $i (0..9) {
            if ($cnt{$i} < $cnt1{$i}) {
                $valid = 0;
                last;
            }
        }
        
        # If valid, add to the result
        push @ans, $x if $valid;
    }
    
    return @ans;
}