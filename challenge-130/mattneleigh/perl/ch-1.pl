#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    # Given data sets
    [ 2, 5, 4, 4, 5, 5, 2 ],
    [ 1, 2, 3, 4, 3, 2, 1, 4, 4 ],

    # Some extra test cases
    [ 1, 1, 2, 2, 3, 3 ],
    [ 5, 7, 7, 5, 9, 5, 5, 2 ]
);
my $list;

foreach $list (@lists){
    my ($number, $times) = find_odd_occurrences($list);

    printf("Input: (%s)\n", join(", ", @{$list}));
    if(defined($number)){
        printf(
            "    %d was observed %d time%s.\n",
            $number,
            $times,
            $times == 1 ? "" : "s"
        );
    } else{
        print("    No number was observed an odd number of times.\n");
    }

    print("\n");

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Examine a array of integers to find one that appears an odd number of times.
# If more than one such integer exists, the smallest one will be returned.
# Takes one argument:
# * A ref to an array of integers
# Returns on success:
#   In scalar context:
#     * The smallest integer found (see above)
#   In list context:
#     * A list that contains the smallest integer found, and the number of
#       times it was observed in the supplied array
# Returns on error:
#   In scalar context:
#     * undef if no integer was found an odd number of times 
#   In list context:
#     * (undef, undef) if no integer was found an odd number of times
################################################################################
sub find_odd_occurrences{
    my $list = shift();

    my %table = ();

    # Loop over the list, and count how many
    # times each number appears in it
    foreach(@{$list}){
        if($table{$_}){
            $table{$_}++;
        } else{
            $table{$_} = 1;
        }
    }

    # See if one of the counts is odd- if so
    # return the smallest such number and,
    # if in list context, the count as well
    foreach(sort({ $a <=> $b } keys(%table))){
        if($table{$_} % 2){
            if(wantarray()){
                return($_, $table{$_});
            } else{
                return($_);
            }
        }
    }

    # Didn't find an odd count
    if(wantarray()){
        return(undef, undef);
    } else{
        return(undef);
    }

}



