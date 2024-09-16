#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 2, 3, 4 ],
    [ 1, 2, 2, 3, 3, 3 ],
    [ 1, 1, 1, 3 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    my $rval = find_lucky_integer(@{$integer_list});

    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        defined($rval) ?
            $rval
            :
            -1
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, find a Lucky Number within, where a Lucky Number
# is defined as a number that appears in the array a number of times equal to
# its own value.  If more than one exists, the largest will be returned; if
# none exist, undef will be returned.
# Takes one argument:
# * An array of integers to examine (e.g. ( 1, 2, 2, 3, 3, 3 ) )
# Returns on success:
# * The largest Lucky Number found within the list (e.g. in the case above, 3 )
# Returns on error:
# * undef if no Lucky Number could be found within the array
################################################################################
sub find_lucky_integer{

    my $int;
    my %frequency_table;

    # Count how often each integer appears in the
    # array
    foreach $int (@ARG){
        $frequency_table{$int}++;
    }

    # Examine each integer that was seen, after
    # sorting them in descending order
    foreach $int (sort({ $b <=> $a } keys(%frequency_table))){
        # Return this integer if its frequency is equal
        # to its own value, making it a Lucky Number
        return($int)
            if($frequency_table{$int} == $int);
    }

    # If we got here, no lucky number was found
    return(undef);

}



