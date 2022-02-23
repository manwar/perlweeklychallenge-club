#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $n = 10;

printf(
    "\nThe first %d Left Factorials are:\n    %s\n\n",
    $n,
    join(", ", n_left_factorials($n))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the first N Left Factorials (See OEIS A003422)
# Takes one argument:
# * A positive integer indicating how many Left Factorials to calculate
# Returns on success:
# * A list of the first N Left Factorials
# Returns on error:
# * undef if N is not a positive integer
################################################################################
sub n_left_factorials{
    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my $i;
    my $factorial;
    my @left_factorials;

    # Initial setup
    push(@left_factorials, 1);
    $factorial = 1;

    for $i (1 .. ($n - 1)){
        # Multiply our running product by $i, then
        # store its sum with the previous sum
        $factorial *= $i;
        push(
            @left_factorials,
            $left_factorials[$#left_factorials] + $factorial
        );
    }

    return(@left_factorials);

}



