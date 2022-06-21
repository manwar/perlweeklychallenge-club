#!/usr/bin/perl

use strict;
use warnings;
use English;

use POSIX;

################################################################################
# Begin main execution
################################################################################

my $n = 10;
my @primorials = calculate_primorial_numbers($n);
my $output_format =
    "P(%d) = %"
    .
    ceil(log($primorials[$#primorials][0]) / log(10))
    .
    "d (%s)\n";

print("\n");
for my $i (0 .. $#primorials){
    printf(
        $output_format,
        $i,
        $primorials[$i][0],
        join("*", map($primorials[$_][1], (0 .. $i)))
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate a specified quantity of the first primorial numbers
# Takes one argument:
# * The number N of primorial numbers to calculate
# Returns on success:
# * A list of primorial numbers and the largest prime factor used to calculate
#   each, e.g.:
#
#   @output = (
#       [  1, 1 ],
#       [  2, 2 ],
#       [  5, 3 ],
#       [ 30, 5 ],
#       ...
#   );
#
# Returns on error:
# * undef if N is not at least one (1)
################################################################################
sub calculate_primorial_numbers{
    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my @primorials = ( [ 1, 1 ] );
    my $next_prime = 2;

    # Loop until we've found enough primorial
    # numbers 
    while(scalar(@primorials) < $n){
        # Calculate and store the next primorial
        # and its factor list
        push(
            @primorials,
            [
                $primorials[$#primorials][0] * $next_prime,
                $next_prime
            ]
        );

        # Calculate the prime for the next
        # iteration
        until(is_prime(++$next_prime)){
            ;;
        }
    }

    return(@primorials);

}



################################################################################
# Determine whether a given integer N is prime
# Takes one argument:
# * The integer N
# Returns on success:
# * 1 if N is prime
# * 0 if N is not prime
# NOTE: If N is less than zero, it will always be considered nonprime
################################################################################
sub is_prime{
    my $n = int(shift());

    my $i;

    # Take care of a few easy cases
    return(1)
        if(($n == 2) || ($n == 3));
    return(0)
        if(($n <= 1) || !($n % 2) || !($n % 3));

    # See if certain factors divide evenly
    for($i = 5; $i * $i <= $n; $i += 6){
        if(!($n % $i) || !($n % ($i + 2))){
            return(0);
        }
    }

    return(1);

}



