#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings_and_letters = (
    # Given cases
    [ "programming", "g" ],
    [ "hello",       "h" ],
    [ "abcdefghij",  "h" ],
    [ "reverse",     "s" ],
    [ "perl",        "r" ],

    # Additional test cases
    [ "missing",     "x" ]
);

print("\n");
foreach my $string_and_letter (@strings_and_letters){
    printf(
        "Input: \$str = \"%s\", \$char = \"%s\"\nOutput: \"%s\"\n\n",
        $string_and_letter->[0],
        $string_and_letter->[1],
        reverse_string_prefix($string_and_letter)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string and a character to find therein, reverse the contents of the
# string from the beginning up to and including the location of the first
# instance of the specified character
# Takes one argument:
# * A ref to an array containing the string to examine and the character to
#   search for (e.g. [ "programming", "g" ] )
# Returns:
# * The supplied string, with all characters reversed up to and including the
#   first instance of the specified character (e.g. "gorpramming" )
#   - OR -
# * The unmodified string if the specified character was not found
################################################################################
sub reverse_string_prefix{

    my $max = length($ARG[0][0]) - 1;
    my $i;
    my $char;
    my $reverse = "";

    # Loop over all letters in the string
    for $i (0 .. $max){
        # Extract the letter at the current
        # location and add it to the start of the
        # reversed string
        $char = substr($ARG[0][0], $i, 1);
        $reverse = $char . $reverse;

        # If the current letter is the one we're
        # looking for, concatenate the reversed
        # string (which includes the current
        # letter) with what's left of the original
        # string, and return
        return($reverse . substr($ARG[0][0], -($max - $i)))
            if($char eq $ARG[0][1]);
    }

    # If we got here, the desired letter was
    # not found
    return($ARG[0][0]);

}



