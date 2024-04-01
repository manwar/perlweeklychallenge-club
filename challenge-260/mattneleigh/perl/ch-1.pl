#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 2, 1, 1, 3 ],
    [ 1, 2, 3 ],
    [ -2, 0, 1, -2, 1, 1, 0, 1, -2, 9 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        has_only_unique_occurrences(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an array of integers consists solely of numbers that each
# appear a unique number of times
# Takes one argument:
# * The list of integers to examine
# Returns:
# * 1 if each number in the list appears a unique number of times
# * 0 if at least two numbers in the list appear the same number of times
################################################################################
sub has_only_unique_occurrences{

    my %table_a;
    my %table_b;

    # Loop the given arguments and build a
    # frequency table
    foreach(@ARG){
        $table_a{$_}++;
    }

    # Loop over all the values seen within the
    # argument list
    foreach(keys(%table_a)){
        # Have we seen this instance count before?
        if($table_b{$table_a{$_}}){
            # We have- occurrences are not unique
            return(0);
        } else{
            # We haven't- make a note that this count has
            # been seen
            $table_b{$table_a{$_}} = 1;
        }
    }

    # Every instance count was unique
    return(1);

}



