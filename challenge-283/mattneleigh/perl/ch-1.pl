#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 3, 3, 1 ],
    [ 3, 2, 4, 2, 4 ],
    [ 1 ],
    [ 4, 3, 1, 1, 1, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    my $rval = find_solitary_element(@{$integer_list});

    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        defined($rval) ?
            $rval
            :
            0
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, find one that appears only once
# Takes one argument:
# * An array of integers to examine (e.g. ( 3, 3, 1 ) )
# Returns on success:
# * An element that appears only once; if more than one element qualifies, the
#   first is returned (e.g. 1 )
# Returns on error:
# * undef if no element was found only once
################################################################################
sub find_solitary_element{

    my %frequency_table;
    my $int;

    # Build a frequency table, counting instances
    # of each element
    foreach $int (@ARG){
        $frequency_table{$int}++;
    }

    # Examine the frequency of each element
    foreach $int (@ARG){
        # Found something that appeared once- return
        # it
        return($int)
            if($frequency_table{$int} == 1);
    }

    # Got here?  Must not have found anything that
    # appeared only once
    return(undef);

}



