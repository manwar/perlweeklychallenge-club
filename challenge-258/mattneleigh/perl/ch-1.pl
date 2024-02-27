#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 10, 1, 111, 24, 1000 ],
    [ 111, 1, 11111 ],
    [ 2, 8, 1024, 256 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        count_ints_with_even_digits(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, determine how many have an even number of digits
# Takes one argument:
# * A list of integers to examine
# Returns
# * The count of integers that have an even number of digits
################################################################################
sub count_ints_with_even_digits{

    my $count = 0;

    foreach my $integer (@ARG){
        # Remove anything that isn't a digit
        $integer =~ s/\D//g;

        # Increment the count unless the number of
        # digits is odd
        $count++
            unless(length($integer) % 2);
    }

    return($count);

}



