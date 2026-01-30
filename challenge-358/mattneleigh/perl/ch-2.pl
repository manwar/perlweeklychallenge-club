#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @encryption_data_sets = (
    # Given cases
    [ "abc",             1 ],
    [ "xyz",             2 ],
    [ "abc",            27 ],
    [ "hello",           5 ],
    [ "perl",           26 ],

    # Additional test cases
    [ "CApZ",            5 ],
    [ "AaBbCc XxYyZz!", 13 ]
);

print("\n");
foreach my $encryption_data (@encryption_data_sets){
    printf(
        "Input: \$str = \"%s\", \$int = %d\nOutput: \"%s\"\n\n",
        @{$encryption_data},
        rot_n_encode(@{$encryption_data})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string and a positive integer, perform a rotation cipher on the
# contents, replacing letters of the English alphabet with equivalents from the
# specified number of places ahead, wrapping around from the beginning of the
# alphabet if the specified rotation would go beyond 'z'.  Only letter
# characters (A-Z, a-z) are transliterated; letter case is preserved.
# Takes two arguments:
# * The string to encode, of which only the letter characters (see above) will
#   be rotated (e.g. "Your ad here!")
# * A positive integer that indicates the number of places within the alphabet
#   to rotate each letter character (e.g. 13)
# Returns:
# * A copy of the original string, with all letter characters rotated by the
#   specified number of spaces within the alphabet (e.g. "Lbhe nq urer!")
################################################################################
sub rot_n_encode{

    return(
        # Combine the characters, modified or
        # otherwise, back into a string
        join(
            "",
            map(
                # Convert the computed value back to a
                # character
                chr(
                    # Convert the character to its ordinal value
                    # en passant and see if it's a lower-case
                    # letter
                    ((($_ = ord($_)) >= 97) && ($_ <= 122)) ?
                        # This is a lower case letter- compute its
                        # rotated value
                        ($_ += ($ARG[1] % 26)) <= 122 ? $_ : $_ - 26
                        :
                        (($_ >= 65) && ($_ <= 90)) ?
                            # This is an upper case letter- compute its
                            # rotated value
                            ($_ += ($ARG[1] % 26)) <= 90 ? $_ : $_ - 26
                            :
                            # This is not a letter- pass its value
                            # through unmodified
                            $_
                ),
                # Get a list of characters from the string
                split("", $ARG[0])
            )
        )
    );

}



