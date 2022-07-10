#!/usr/bin/perl

use strict;
use warnings;
use English;

use POSIX;

################################################################################
# Begin main execution
################################################################################

my @number_sets = (
    [ 0, 0, 1, 2, 63, 61, 27, 13 ],
    [ 6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49 ],
    [ 7, 15, 36, 39, 40, 41 ]
);

print("\n");
foreach my $number_set (@number_sets){
    my @five_numbers = five_number_summary(@{$number_set});
    my $field = 0;
    my @fields = ("Min", "1st Quart", "Median", "2nd Quart", "Max");
    my $dec_places = 2;
    my $field_format =
        # Maximum length of a field label in @fields
        "    %-9s - %"
        .
        # Calculate width of the number field based
        # on the maximum possible value to be displayed
        (ceil(log($five_numbers[4]) / log(10)) + $dec_places + 1)
        .
        "."
        .
        $dec_places
        .
        "f\n";

    printf(
        "Data: %s\nSummary:\n%s\n",
        join(", ", @{$number_set}),
        join(
            "",
            map(
                sprintf(
                    $field_format,
                    $fields[$field++],
                    $_
                ),
                @five_numbers
            )
        )
    );
}


exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate a Five Number Summary of an array of numbers
# Takes one argument:
# * The array of numbers to examine
# Returns:
# * An array containing the following fields based on the supplied array:
#   0 - The Minimum value
#   1 - The First Quartile value
#   2 - The Median (Second Quartile) value
#   3 - The Third Quartile value
#   4 - The Maximum value
################################################################################
sub five_number_summary{
    use POSIX;

    my $lower_mid_index = floor($#ARG / 2);

    # This gets a lot easier of the numbers are in
    # ascending order...
    @ARG = sort({ $a <=> $b } @ARG);

    return(
        # Min
        $ARG[0],

        # First Quartile
        _median(
            \@ARG,
            0,
            (scalar(@ARG) % 2) ?
                # Odd
                $lower_mid_index - 1
                :
                # Even
                $lower_mid_index
        ),

        # Median (Second Quartile)
        _median(\@ARG, 0, $#ARG),

        # Third Quartile
        _median(
            \@ARG,
            $lower_mid_index + 1,
            $#ARG
        ),

        # Max
        $ARG[$#ARG]
    );

}



################################################################################
# Calculate the median of an array of values, or a subset thereof
# Takes three arguments:
# * A ref to the array to examine
# * The lower index to examine
# * The upper index to examine
# Returns:
# * The median of the data within the array betwen the specified index bounds
# NOTE: This function is meant to be called by five_number_summary() only
################################################################################
sub _median{
    use POSIX;

    my $array = shift();
    my $lower = int(shift());
    my $upper = int(shift());

    my $lower_mid = $lower + floor(($upper - $lower) / 2);
    my $median;
    
    # For even and odd numbers of numbers, we start
    # with this
    $median = $array->[$lower_mid];

    unless(($upper - $lower + 1) % 2){
        # An even number of numbers- a little more
        # math
        $median += $array->[$lower_mid + 1];
        $median /= 2;
    }

    return($median);

}



