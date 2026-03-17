#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "10#11#12",
    "1326#",
    "25#24#123",
    "20#5",
    "1910#26#"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        decode_obfuscated_string($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of digits and the '#' character that is encoded as follows:
# * Digits '1' to '9' directly represent the letters 'a' to 'i', respectively
# * The combinations '10#' to '26#' represent the letters 'j' to 'z',
#   respectively
# decode the string to its leter representation
# Takes one argument:
# * An encoded string to decode (e.g. "25#24#123")
# Returns:
# * The decoded string (e.g. "yxabc")
################################################################################
sub decode_obfuscated_string{
    my $string = shift();

    # Add the '-' at the start to effectively
    # make alphabet encodings 1-indexed
    my @letters = qw(
        - a b c d e f g h i j k l m n o p q r s t u v w x y z
    );
    my $encoding;
    my $decoded = "";

    # Loop until the string is consumed
    while(length($string)){
        # Get the first digit of the next encoding
        $encoding = substr($string, 0, 1, "");

        if((length($string) > 1) && (substr($string, 1, 1) eq "#")){
            # This is a two-digit encoding; remove the
            # next two characters from the string, to
            # include the '#', but only retain the second
            # digit in $encoding
            chop($encoding .= substr($string, 0, 2, ""));
        }

        # Add the letter indicated by the encoding
        # to the decoded string
        $decoded .= $letters[$encoding];
    }

    return($decoded);

}



