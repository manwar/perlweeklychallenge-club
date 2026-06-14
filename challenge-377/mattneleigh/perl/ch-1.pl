#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "abcba",
    "racecar",
    "abcd",
    "banana",
    "hello"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %s\n\n",
        $string,
        reverse_substring_present($string, 2) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, determine whether any substring of specified length would
# still be present when the string is reversed
# Takes two arguments:
# * The string to examine (e.g. "");
# * The length of substring to consider, which must be greater than 1 (e.g. 2)
# Returns on success:
# * 0 if no substring the specified length from the original string is still
#   present if the string is reversed
# * 1 if a substring of the specified length from the original string is still
#   present if the string is reversed
# Returns on error:
# * undef if the length of the specified substring is not greater than 1
################################################################################
sub reverse_substring_present{
    my $string = shift();
    my $n = shift();

    return(undef)
        unless($n > 1);

    # Reverse the input string
    my $reverse = join("", reverse(split("", $string)));
    my $length = length($string);

    # Loop over the starting points of all
    # substrings of length $n within both strings
    for my $i (0 .. $length - $n){
        for my $j (0 .. $length - $n){
            # Return 1 if we have a matching substring
            return(1)
                if(substr($string, $i, $n) eq substr($reverse, $j, $n));
        }
    }

    # Got here?  No matching substrings were
    # found
    return(0);

}



