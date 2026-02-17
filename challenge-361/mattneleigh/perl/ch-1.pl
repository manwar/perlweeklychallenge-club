#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints = (4, 12, 20, 96, 100);

print("\n");
foreach my $int (@ints){
    printf(
        "Input: \$int = %d\nOutput: %s\n\n",
        $int,
        join(", ", compute_zeckendorf_representation($int))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a positive integer, compute the Zeckendorf representation of same,
# which consists of a series of non-consecutive Fibonacci numbers whose sum
# equals the integer
# Takes one argument:
# * The integer to examine (e.g. 100)
# Returns:
# * A list that contains the Zeckendorf representation of the supplied integer
#   (e.g. ( 89, 8, 3 ) )
################################################################################
sub compute_zeckendorf_representation{
    my $int = shift();

    my @fib = (1, 1);
    my @results;

    # Create a list of Fibonacci numbers
    {
        my $a = 1;
        my $b = 1;
        my $c;

        while($fib[-1] < $int){
            $c = $a + $b;
            $a = $b;
            $b = $c;

            push(@fib, $b);
        }
    }

    # Loop while we haven't consumed all of $int
    while($int){
        if($fib[-1] <= $int){
            # The largest remaining Fibonacci number is
            # less than the remaining portion of $int;
            # subtract it and store it, popping @fib to
            # skip ahead twice for the next loop
            $int -= $fib[-1];
            push(@results, pop(@fib));
        }

        # Remove the largest Fibonacci number
        pop(@fib);
    }

    return(@results);

}



