#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @values = (3, 5, 7);

print("\n");
foreach(@values){
    printf("gamma(%.3f) = %9.4f\n", $_, gamma($_));
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Compute the Gamma Function using the Lanczos approximation
# Takes one argument:
# * A number N (e.g. 5.5)
# Returns:
# * The gamma function output corresponding to N (e.g. 52.3428)
# See https://en.wikipedia.org/wiki/Lanczos_approximation for details of the
# method used herein
################################################################################
sub gamma{
    # For the pi constant
    use Math::Trig;

    my $z = shift();

    return(pi / (gamma(1 - $z) * sin(pi * $z)))
        if($z < 0.5);

    $z -= 1;

    # Constants shamelessly stolen from the Wiki article
    my $Ag = 0.99999999999980993;
    my @p = (
        676.5203681218851,
        -1259.1392167224028,
        771.32342877765313,
        -176.61502916214059,
        12.507343278686905,
        -0.13857109526572012,
        9.9843695780195716E-6,
        1.5056327351493116E-7
    );
    my $c = ($z + scalar(@p) - 0.5);

    # Compute the series approximation with our values
    # of p
    for my $i (0 .. $#p){
        $Ag += $p[$i] / ($z + $i + 1);
    }

    return(
        sqrt(2 * pi) * $c ** ($z + 0.5)
        *
        exp(-$c) * $Ag
    );

}



