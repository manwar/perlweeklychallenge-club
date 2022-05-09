#!/usr/bin/perl

use strict;
use warnings;
use English;

use POSIX;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    # Given cases
    [ 1, 2, 3, 4, 5 ],
    [ 1, 3, 5, 7, 9 ],

    # Additional test cases
    [ 2, 4, 50, 83, 6, 5, 9 ]
);
my $list;

print("\n");
foreach $list (@lists){
    my $listref = [];
    my $digits;
    my $summation = compute_list_summation($listref, @{$list});

    printf(
        "\nInput: \@n = (%s)\nOutput: %d\n\n",
        join(", ", @{$list}),
        $summation
    );

    # See how many digits we'll need to handle...
    $digits = ceil(log($summation) / log(10));

    # Stick the input list at the head of the list of
    # summation stages and output them in a pretty
    # fashion
    unshift(@{$listref}, $list);
    foreach(@{$listref}){
        printf(
            "%".(4 + scalar(@{$list}) * ($digits + 1))."s\n",
            join(" ", map(sprintf("%".$digits."d", $_), @{$_}))
        );
    }
    print("\n");

}

print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Perform a particular type of list summation on a list of numbers
# Takes two arguments:
# * An array reference for storage of lists from intermediate summation stages,
#   if desired; if this argument is 'undef', no intermediate lists will be
#   stored
# * The list of numbers to process
# Returns:
# * The final value that results from the summation process
################################################################################
sub compute_list_summation{
    my $global_listref = shift();

    my @stage_list;

    # Loop over the last N-1 numbers in the list
    # and add the running total to a new list
    shift();
    push(@stage_list, $ARG[0]);
    for my $i (1 .. $#ARG){
        push(@stage_list, $stage_list[$#stage_list] + $ARG[$i]);
    }

    # Store the list if requested to do so
    push(@{$global_listref}, \@stage_list)
        if(defined($global_listref));

    # If there was just one sum generated, return
    # it
    return($stage_list[0])
        if(scalar(@stage_list) == 1);

    # Otherwise call ourselves on the sum list,
    # return what the deeper call found
    return(compute_list_summation($global_listref, @stage_list));

}



