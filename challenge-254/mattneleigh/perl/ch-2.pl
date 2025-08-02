#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    qw(
        Raku
        Perl
        Julia
        Uiua
    ),

    # Additional test cases
    qw(
        UPPERCASE
        lowercase
        MiXeDcAsE
    )
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$s = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        reverse_vowel_order($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, reverse the positions of all the vowels within, preserving
# original letter case in each position within the string
# Takes one argument:
# * The string to examine (e.g. "Julia")
# Returns:
# * The string, with all vowel positions reversed (e.g. "Jaliu")
# Note that case of each position will be preserved even if letters in that
# position are changed (e.g. "MiXeDcAsE" --> "MeXaDcEsI")
################################################################################
sub reverse_vowel_order{
    my $string = shift();

    my $index = 0;
    my @vowels;
    my @indices;

    # Find each vowel, make a note of where it
    # is, and whether it was capitalized
    foreach my $char (split('', $string)){
        if($char =~ m/[aeiou]/i){
            unshift(@vowels, lc($char));
            # If $char and $vowels[0] match, the original
            # character was lower case
            push(@indices, [ $index, $char eq $vowels[0] ? 0 : 1 ]);
        }

        $index++;
    }

    # Replace vowels with their new counterparts
    # at observed locations, matching original
    # case at each
    for $index (0 .. $#vowels){
        substr(
            $string,
            $indices[$index][0],
            1,
            $indices[$index][1] ?
                uc($vowels[$index])
                :
                $vowels[$index]
        );
    }

    return($string);

}



