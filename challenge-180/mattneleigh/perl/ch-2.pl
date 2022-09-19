#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    {
        list  => [ 1, 4, 2, 3, 5 ],
        value => 3
    },
    {
        list  => [ 9, 0, 6, 2, 3, 8, 5 ],
        value => 4
    }
);

print("\n");
for my $i (0 .. $#lists){
    printf(
        "Input: \@n = (%s) and \$i = %d\n",
        join(",", @{$lists[$i]->{list}}),
        $lists[$i]->{value}
    );

    trim_list_by_value(
        $lists[$i]->{list},
        $lists[$i]->{value}
    );

    printf(
        "Output: (%s)\n\n",
        join(",", @{$lists[$i]->{list}})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Remove from a list of numbers those that are less than or equal to a
# specified integer
# Takes two arguments:
# * A ref to the list to trim; THIS LIST WILL BE MODIFIED as specified above
# * The integer to compare with members of the list for removal purposes
# Returns no meaningful value
################################################################################
sub trim_list_by_value{
    my $list = shift();
    my $n = int(shift());

    my $i = 0;

    # Loop while $i is within the array
    while($i <= $#$list){
        if($list->[$i] > $n){
            # This value doesn't meet search criteria;
            # move on (increment $i)
            $i++;
        } else{
            # This value meets search criteria; remove
            # it (and shrink the list)
            splice(@{$list}, $i, 1);
        }
    }

}



