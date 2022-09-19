#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @numbers = ( 5456, 120, 6 );

print("\n");
foreach(@numbers){
    print(
        $_, 
        " is",
        is_esthetic_number($_) ? "" : " not",
        " an esthetic number.\n"
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether an integer N is an esthetic number (every adjacent digit
# differs from its neighbour by 1)
# Takes one argument:
# * The integer N to examine
# Returns on success:
# * 1 if N is an esthetic number
# * 0 if N is not an esthetic number
# Returns on error:
# * undef if N is less than 1 (not positive)
# NOTE: Traditionally single-digit numbers are considered esthetic and will be
# treated as such here
################################################################################
sub is_esthetic_number{
    my $n = int(shift());

    return(undef)
        if($n < 1);

    my @digits = split("", $n);

    for my $i (0 .. ($#digits - 1)){
        return(0)
            unless(abs($digits[$i] - $digits[$i + 1]) == 1);
    }

    return(1);

}



