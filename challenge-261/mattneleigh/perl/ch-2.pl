#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ 5, 3, 6, 1, 12 ],
        3
    ],
    [
        [ 1, 2, 4, 3 ],
        1
    ],
    [
        [ 5, 6, 7 ],
        2
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \@ints = (%s) and \$start = %d\nOutput: %d\n\n",
        join(", ", @{$data_set->[0]}),
        $data_set->[1],
        double_within_list_values($data_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers and a start value, continue doubling the start value
# until a value that is NOT in the list is reached; this value is then
# returned.  If the original value was not found in the list, it is returned
# unaltered.
# Takes one argument:
# * A ref to a data structure that contains the list of integers to examine,
#   and the start value (e.g.
#       [
#           [ 5, 3, 6, 1, 12 ],
#           3
#       ]
#   )
# Returns:
# * The first doubled value that does NOT appear in the list, or the original
#   start value if it did not appear in the list (e.g. 24 )
################################################################################
sub double_within_list_values{

    # Make a lookup table of supplied array
    # values
    my %value_table = map(
        { $_ => 1 }
        @{$ARG[0][0]}
    );
    my $value = $ARG[0][1];

    # Double $value while its current... er,
    # value... keeps appearing in the table
    while($value_table{$value}){
        $value *= 2;
    }

    return($value);

}



