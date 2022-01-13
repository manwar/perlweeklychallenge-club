#!/r/bin/perl
use strict;
use warnings;

# with this script, you can check whether an input list is sorted or not
# https://theweeklychallenge.org/blog/perl-weekly-challenge-139/#TASK1

### logic of the script
#
# the script will determine if a list is sorted by comparing each elements numeric difference to the first element in the list.
# an increasingly sorted list is characterized by a constant increase of each elements difference to the first element.
# a decreasingly sorted list is characterized by a constant decrease of each elements difference to the first element.
# constant differences are valid since list with duplicates are considered sorted, see 2.
# without warning upon other input.
# 1.  if the input is only one element, the list is considered sorted and the script will exit.
#
# 2.  subsequent diplicates are considered sorted. example lists
#     (1,1,2) (1,2,2,3)
#     input beginning with duplicates will be shifted until the list's first 2 elements are different from each other.
# this is necessary as the check_sorting subroutine is required to differentiate between increasing and decreasing lists.
# an initial difference (difference between 1st and 2nd element of input) of 0 does not provide the necessary positive or negative direction.
#
# 3.  after the initial difference is determined, we know if the list must be checked against increase or decrease.
# sub check_sorting checks against several conditions while recursively chopping the list's head of.
# if we get to the last list element without violating the rule of constantly increasing / decreasing differences, we know the list is sorted or not.
#
###

### limits of the script
#
# the script works only with ints without warning upon other input.
#
###

# get input
print "input: ";
my @input_list = <STDIN>;
chomp @input_list;

# if list has only 1 element it is considered sorted
my $list_length = @input_list;
if ( $list_length < 2) {
    print "1\n";
    exit;
}

# shift list if it begins with duplicates.
# this is necessary because the first difference in a list determines, if it is an increasing or decreasing list.
# the check_sorting subroutine depends on this discrimination
# if the first difference is 0, this discrimination cannot take place
my $initial_element = $input_list[0];
while ( $list_length > 1 && $initial_element eq $input_list[1] ) {
    shift ( @input_list ); 
}

my $initial_difference = $input_list[1] - $initial_element;
printf ( "%i\n", check_sorting ( $initial_element, @input_list, $initial_difference ) );

sub check_sorting {
    my $length_leftover = @input_list;
    # if there is only one element left in the list, and the subroutine is called again, the list is sorted
    return 1 if ( $length_leftover < 2);

    # if the initial difference is negative, any subsequent difference must not be larger than that
    if ( $initial_difference < 0 && $input_list[1] - $initial_element > $initial_difference ) {
        return 0;
    }
    # if the initial difference is positive, any subsequent difference must not be smaller than that
    if ( $initial_difference >= 0 && $input_list[1] - $initial_element < $initial_difference ) {
        return 0;
    }
    else {
        shift ( @input_list );
        check_sorting ( @input_list );
    }
}