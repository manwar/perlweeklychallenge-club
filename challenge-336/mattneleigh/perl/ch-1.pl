#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 1, 2, 2, 2, 2 ],
    [ 1, 1, 1, 2, 2, 2, 3, 3 ],
    [ 5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7 ],
    [ 1, 2, 3, 4 ],
    [ 8, 8, 9, 9, 10, 10, 11, 11 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        array_evenly_regroupable(@{$integer_list}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, determine whether they can be divided into groups
# in which all members of each group has the same value, the groups have the
# same number of members, and each group has at least two members
# Takes one argument:
# * The array of integers to examine (e.g. (8, 8, 9, 9, 10, 10, 11, 11) )
# Returns:
# * 0 if the array does not meet the criteria described above
# * 1 if the array meets the criteria described above (as would be the case in
#   the example provided)
################################################################################
sub array_evenly_regroupable{
    use List::Util qw(min);

    my %count_table;
    my @counts;
    my $min;

    # Count the instances of each number
    foreach(@ARG){
        $count_table{$_}++;
    }

    # Make a list of counts and find the smallest
    @counts = map($count_table{$_}, keys(%count_table));
    $min = min(@counts);

    # Make sure the smallest count is at least 2
    return(0)
        unless($min > 1);

    # Return 0 if any count isn't evenly divisible
    # by the minimum count
    foreach my $count (@counts){
        return(0)
            if($count % $min);
    }

    # Got here- the array met our criteria;
    # return 1
    return(1);

}



