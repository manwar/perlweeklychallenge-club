#!/usr/bin/perl

use strict;
use warnings;
use English;

use Config;
$Config{useithreads}
    or die(
        "Threads required; recompile Perl with threads to run this program."
    );
use threads;
use threads::shared;

################################################################################
# Begin main execution
################################################################################

my @numbers = (
    # No set of test values was specified,
    # so I created this one
    3, 10, 45, 1, 75, 2, 100, 32, 74, 9, 4, 22, 53, 7, 14, 89, 5
);

print("Input:  ", join(", ", @numbers), "\n");
print("Output: ", join(", ", sleep_sort(@numbers)), "\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################




################################################################################
# Perform the Sleep Sort on a list of numerical values
# Takes one argument:
# * The list of numerical values, preferably integers
# Returns:
# * The numerical values provided as input, sorted in ascending order.
#   Probably, anyway.  It's best to run this when the CPU isn't particularly
#   busy if accurate sorting results are desired.
################################################################################
sub sleep_sort{

    my @threads;
    my @sorted :shared;

    # Start a thread for each value in the
    # number list
    foreach(@ARG){
        push(
            @threads,
            threads->create(\&_sleep_sort_thread_core, $_, \@sorted)
        );
    }

    # Join with all spawned threads; we
    # don't care in what order they finish,
    # we just need to know when they're all
    # done
    foreach(@threads){
        $_->join();
    }

    return(@sorted);

}



################################################################################
# Perform one thread's worth of work in the Sleep Sort
# Takes two arguments:
# * A numerical value (preferably an integer) to insert into the sorted list at
#   the proper time
# * A ref to the sorted list, which must have the ':shared' attribute applied
#   (see the documentation for 'threads' and 'threads::shared')
# Returns:
# * undef in all cases, which conveys no meaningful information
# NOTE: This function should ONLY be called by sleep_sort()
################################################################################
sub _sleep_sort_thread_core{
    my $value = shift();
    my $sorted = shift();

    # Block for a unit of time proportional
    # to the value we're given; due to the
    # vagaries of thread scheduling,
    # reliable sort order could not be
    # achieved with a granularity of less
    # than 1/10th of a second- and even
    # that's iffy if the CPU is busy
    select(undef, undef, undef, 0.1 * $value);

    # Store the value in the shared list
    push(@{$sorted}, $value);

    return(undef);
 
}



