#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $a = "1234";
my $b = "5678";
my $n = 51;

printf(
    "\n    Input: \$a = '%s' \$b = '%s' \$n = %d\n    Output: %s\n\n",
    $a, $b, $n,
    fibonacci_words($a, $b, $n)
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Concatenate strings in a manner analagous to the calculation of Fibonacci
# numbers, and get the Nth character from the string once the string has at
# least that many characters
# Takes three arguments:
# * The first string to concatenate
# * The second string to concatenate
# * An integer N that indicates which character in the constructed string is
#   desired
# Returns on success:
# * The Nth character in the constructed string
# Returns on error:
# * undef if N is not greater than zero (0)
################################################################################
sub fibonacci_words{
    my $a = shift();
    my $b = shift();
    my $n = int(shift());

    return(undef)
        unless($n > 0);

    my $c = "";

    # Loop until the string is long enough
    while(length($b) < $n){
        $c = $a . $b;
        $a = $b;
        $b = $c;
    }

    # String is zero-indexed so subtract
    # from $n
    return(substr($b, $n - 1, 1));

}



