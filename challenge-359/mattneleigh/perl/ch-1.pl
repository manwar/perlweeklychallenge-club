#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integers = (
    38,
    7,
    999,
    1999999999,
    101010
);

print("\n");
foreach my $integer (@integers){
    printf(
        "Input: \$int = %d\nOutput: Persistence  = %d\n"
        .
        "        Digital Root = %d\n\n",
        $integer,
        persistence_and_digital_root($integer)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Compute the Additve Persistence and Digital Root of an integer, where the
# Additive Persistence is the number of times one must recursively sum the
# digits of the supplied integer until a single digit results, and the Digital
# Root is that single digit
# Takes one argument:
# * The integer to examine (e.g. 999)
# Returns:
# * A list containing the Additive Persistence and Digital Root of the supplied
#   integer (e.g. (2, 9) )
################################################################################
sub persistence_and_digital_root{
    use List::Util qw(sum);

    my $int = shift();

    my $iterations = 0;

    # Loop until we have just one digit
    while($int > 9){
        # Sum all the digits, and increment the
        # iteration counter
        $int = sum(split("", $int));
        $iterations++;
    }

    return($iterations, $int);

}



