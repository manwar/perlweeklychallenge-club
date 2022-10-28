#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @pairs = (
    [ 5, 4 ],
    [ 4, 6 ],
    [ 2, 5 ],
    [ 3, 1 ],
    [ 7, 4 ]
);

print("\n");
foreach my $pair (@pairs){

    printf(
        "Input: \$x = %d, \$y = %d\nOutput: %d\n\n",
        $pair->[0], $pair->[1],
        total_zero_ops($pair->[0], $pair->[1])
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the number of operations required to make two positive integers (X and
# Y) zero using the following rules:
#   1) X = X - Y if X >= Y
#   2) Y = Y - X if Y >= X (using the original value of X)
# Takes two arguments:
# * The positive integer X (e.g. 5)
# * The positive integer Y (e.g. 4)
# Returns
# * The number of operations required to make X and Y both equal 0 (e.g. 5)
################################################################################
sub total_zero_ops{
    my $x = shift();
    my $y = shift();

    my $ops = 0;

    while($x || $y){
        my $x_orig = $x;

        # Both rules can fire in the same iteration,
        # but expected results (see original problem
        # spec) are only achieved if we count iterations,
        # not actual operations performed...
        if($x >= $y){
            $x -= $y;
        }
        if($y >= $x_orig){
            $y -= $x_orig;
        }
        $ops++;
    }

    return($ops);

}



