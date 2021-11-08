#!/usr/bin/perl

use strict;
use warnings;

################################################################################
# Begin main execution
################################################################################

my @args = (
    [ 12, 3 ],
    [ 18, 4 ]
);

foreach(@args){
    printf(
        "m = %3d    n = %1d  ->  %3d\n",
             $_->[0],   $_->[1], invert_bit(@{$_}));
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Invert the specified bit in an integer between 0 and 255; that is to say, if
# the bit is 1, make it 0, and vice versa
# Takes two arguments:
# * The integer (M) to modify
# * The bit (N; 1-8) to be inverted
# Returns on success:
# * The modified integer
# Returns on error:
# * undef if M is not between 0 and 255, inclusive, or N is not between 1 and
#   8, inclusive
################################################################################
sub invert_bit{
    my $m = shift();
    my $n = shift();

    unless($m > -1 && $m < 256 && $n > 0 && $n < 9){
        return(undef);
    }

    return(
        $m ^ (0x01 << ($n - 1))
    );

}



