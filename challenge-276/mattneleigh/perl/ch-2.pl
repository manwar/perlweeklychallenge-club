#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 2, 4, 1, 5 ],
    [ 1, 2, 3, 4, 5 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        count_elements_at_max_frequency(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, count the number that occur at the highest
# frequency within the list; if two or more values occur at the maximum
# frequency, the total number of elements with those values will be returned
# Takes one argument:
# * A list of integers to examine (e.g. ( 1, 2, 2, 4, 1, 5 ) )
# Returns:
# * The number of elements in the list that share occur at the highest
#   frequency (e.g. 4, as both 1 and 2 are tied at the maximum frequency)
################################################################################
sub count_elements_at_max_frequency{

    my %freq_table;
    my $max_freq = 0;
    my $max_freq_total = 0;

    # Set up a table of frequencies keyed by
    # values observed in the list- while also
    # making note of the maximum frequency yet
    # observed
    foreach(@ARG){
        $freq_table{$_}++;
        $max_freq = $freq_table{$_}
            if($freq_table{$_} > $max_freq);
    }

    # Calculate the total number of elements
    # that had the maximum frequency (there may
    # be more than one value that reached this
    # count)
    foreach(keys(%freq_table)){
        $max_freq_total += $max_freq
            if($freq_table{$_} == $max_freq);
    }

    return($max_freq_total);

}



