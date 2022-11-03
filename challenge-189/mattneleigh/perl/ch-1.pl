#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    [ [ qw( e m u g ) ], 'b' ],
    [ [ qw( d c e f ) ], 'a' ],
    [ [ qw( j a r )   ], 'o' ],
    [ [ qw( d c a f ) ], 'a' ],
    [ [ qw( t g a l ) ], 'v' ]
);

print("\n");
foreach my $array (@arrays){
    my $greater_char = find_greater_character($array->[1], @{$array->[0]});

    printf(
        "Input: \@array = qw/%s/, \$target = '%s'\nOutput: %s\n\n",
        join(" ", @{$array->[0]}),
        $array->[1],
        defined($greater_char) ? $greater_char : $array->[1]
    );
}


exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the smallest character in a given array that is lexicographically
# greater than a specified character
# Takes two arguments:
# * The target character to use as the datum when examining the array
# * The array to examine
# Returns:
# * The smallest character in the array that is lexicographically greater than
#   the target character
# - OR -
# * undef if no such character could be found within the array
################################################################################
sub find_greater_character{
    my $ord_char = ord(shift());

    my $diff = undef;
    my $diff_index = undef;
    my $i = scalar(@ARG);

    while($i--){
        my $next_diff = ord($ARG[$i]) - $ord_char;

        # If $next_diff isn't greater than zero, the
        # char examined was not greater than the
        # target- skip it; if a previous diff has been
        # defined BUT this diff is greater than that
        # diff- skip it
        next
            if(!($next_diff > 0) || ($diff && ($next_diff > $diff)));

        $diff = $next_diff;
        $diff_index = $i;
    }

    return(defined($diff) ? $ARG[$diff_index] : undef);

}



