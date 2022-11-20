#!usr/bin/perl -w
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';

my $enableTests = 0;
# Challange 191 - 1 - Twice Largest
# You are given list of integers, @list.

# Write a script to find out whether the largest item in the list is at least twice as large as 
# each of the other items.


sub twiceLargest(@list)
{
    die "The given list has only one element. Stopped"    if($#list == 0);
    
    @list = sort @list;
    
    print "\nThe largest in the given list is $list[-1]. ";
    
    if($list[-1] >= (2 * $list[-2]) )
    {
        say "Also $list[-1] is greater than twice of every remaining elements."
    }
    else
    {
        say "However $list[-1] is not greater than twice of every remaining elements."
    }

}



my @list0 = (1,2,3,4);
twiceLargest(@list0)    if($enableTests);
# The largest in the given list is 4. However 4 is not greater than twice of every remaining elements.

my @list1 = (1,2,0,5);
twiceLargest(@list1)    if($enableTests);
# The largest in the given list is 5. Also 5 is greater than twice of every remaining elements.

my @list2 = (2,6,3,1);
twiceLargest(@list2)    if($enableTests);
# The largest in the given list is 6. Also 6 is greater than twice of every remaining elements.

my @list3 = (4,5,2,3);
twiceLargest(@list3)    if($enableTests);
# The largest in the given list is 5. Also 5 is not greater than twice of every remaining elements.