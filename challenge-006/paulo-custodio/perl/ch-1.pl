#!/usr/bin/perl

# Challenge 006
#
# Challenge #1
# Create a script which takes a list of numbers from command line and print the
# same in the compact form. For example, if you pass "1,2,3,4,9,10,14,15,16" 
# then it should print the compact form like "1-4,9,10,14-16".

use strict;
use warnings;
use 5.030;

my @nums = sort {$a<=>$b} split /\D+/, "@ARGV";
while (@nums) {
    my $n = shift @nums;
    print $n;
    if (@nums>1 && $nums[0]==$n+1 && $nums[1]==$n+2) {
        $n = shift @nums while @nums && $nums[0]==$n+1;
        print "-$n";
    }
    print "," if @nums;
}
print "\n";
