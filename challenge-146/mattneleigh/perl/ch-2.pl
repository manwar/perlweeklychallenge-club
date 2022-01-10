#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @fractions = (
    # Given cases
    [ 3, 5 ],
    [ 4, 3 ],

    # Additional test cases
    [ 1, 1 ],
    [ 0, 0 ]
);

foreach(@fractions){
    my ($a, $b, $c, $d) = (undef, undef, undef, undef);

    ($a, $b) = curious_fraction_parent(@{$_});
    if(defined($a)){
        ($c, $d) = curious_fraction_parent($a, $b);
    }

    printf("Input: \$member = '%s';\n", join("/", @{$_}));
    printf(
        "Output: parent = '%s' and grandparent = '%s'\n\n",
        defined($a) ? $a."/".$b : "None",
        defined($c) ? $c."/".$d : "None",
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the fraction held in the parent node of a given node from a Curious
# Fraction Tree (see
# https://gdaymath.com/lessons/fractions/5-3-a-curious-fraction-tree/ )
# Takes two arguments:
# * The numerator, A, from the fraction (e.g. 4 )
# * The denominator, B, from the fraction (e.g. 3 )
# Returns on success:
# * A list containing the numerator and denominator of the parent (e.g.
#   (1, 3) )
# Returns on error:
# * A list containing (undef, undef) if the supplied fraction was the root node
#   (1/1) or was invalid in some way (negative or zero values)
################################################################################
sub curious_fraction_parent{
    my $a = int(shift());
    my $b = int(shift());

    if(
        (($a == 1) && ($b == 1))
        ||
        ($a < 1)
        ||
        ($b < 1)
    ){
        # This is the root node or an
        # invalid node- there is no
        # parent (only Zuul...)
        return(undef, undef);
    }

    if($a < $b){
        # We're a Left Node
        return($a, $b - $a);
    } else{
        # We're a Right Node
        return($a - $b, $b);
    }

}



