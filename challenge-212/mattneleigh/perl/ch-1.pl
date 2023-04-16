#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @words = (
    # Given cases
    [
        "Perl",
        [ 2, 22, 19, 9 ]
    ],
    [
        "Raku",
        [ 24, 4, 7, 17 ]
    ],

    # Additional test cases
    [
        "AMTK",
        [ 0, 7, 25, 21 ]
    ],
    [
        "IBM",
        [ -1, -1, -1 ]
    ],
    [
        "Wow!",
        [ 11, -10, 2, 13 ]
    ]
);

print("\n");
foreach my $word (@words){
    printf(
        "Input: \$word = \'%s\' and \@jump = (%s)\nOutput: %s\n\n",
        $word->[0],
        join(", ", @{$word->[1]}),
        character_rotate($word->[0], @{$word->[1]})
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Rotate the letters of a string a specified number of places within the
# alphabet, wrapping around at the ends as appropriate.  Case is preserved;
# non-letter characters are passed through unchanged.  Shift values may be
# positive (e.g. 1 shifts A to B) or negative (e.g. -1 shifts B to A).
# Takes two arguments:
# * The string to modify
# * A list of integers that determine how far a character is to be rotated
#   within the alphabet; this must be at least as long as the number of
#   characters in the string
# Returns:
# * The modified string
################################################################################
sub character_rotate{

    my $outstr = "";

    # Loop over each character of the supplied
    # string
    foreach my $char (split('', shift())){
        my $base;

        if((ord($char) >= 97) && (ord($char) <= 122)){
            # a-z
            $base = 97;
        } elsif((ord($char) >= 65) && (ord($char) <= 90)){
            # A-Z
            $base = 65;
        } else{
            # Something else...?  Add it to the output
            # string, ignore the jump value for this
            # glyph, and skip ahead to the next
            # character
            $outstr .= $char;
            shift();
            next;
        }

        # Calculate the new character after the
        # rotation value is applied (modular
        # division wraps large values back to the
        # start of the alphabet) and add it to
        # the output string
        $outstr .= chr((ord($char) - $base + shift()) % 26 + $base);
    }

    return($outstr);

}



