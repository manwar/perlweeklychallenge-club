#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @orders = ( 5, 7, 4 );
my $order;

foreach $order (@orders){
    printf(
        "\nInput: \$n = %d\nOutput: %s\n",
        $order,
        join(
            ", ",
            map(
                $_->[0] . "/" . $_->[1],
                calculate_farey_sequence($order)
            )
        )
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate a Farey sequence of a given order N
# Takes one argument:
# * The order N, which must be an integer greater than zero (e.g. 4)
# Returns on success:
# * The Farey sequence of order N, in ascending order, in the form of a list of
#   numerator/denominator pairs (e.g. ([ 0, 1 ], [ 1, 4 ], ... [ 1, 1 ]) )
# Returns on error:
# * undef if N is not greater than zero
################################################################################
sub calculate_farey_sequence{
    use POSIX;

    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my @sequence = (
        [ 0,  1 ],
        [ 1, $n ]
    );

    # Loop until we have unity at the end
    # of the sequence
    while($sequence[$#sequence][0] != $sequence[$#sequence][1]){
        my $k = floor(
            ($n + $sequence[$#sequence - 1][1])
            /
            $sequence[$#sequence][1]
        );

        push(
            @sequence,
            [
                $k * $sequence[$#sequence][0] - $sequence[$#sequence - 1][0],
                $k * $sequence[$#sequence][1] - $sequence[$#sequence - 1][1]
            ]
        );
    }

    return(@sequence);

}



