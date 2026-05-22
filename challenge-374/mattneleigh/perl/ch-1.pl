#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "aeiou",
    "aaeeeiioouu",
    "aeiouuaxaeiou",
    "uaeiou",
    "aeioaeioa"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: (%s)\n\n",
        $string,
        join(
            ", ",
            map(
                "\"" . $_ . "\"",
                sort(comprehensive_vowel_substrings($string))
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, return all substrings therein that contain only lower-case
# English vowels (a, e, i, o, u) and include all five vowels in any order
# Takes one argument:
# * The string to examine (e.g. "aeiouuaxaeiou")
# Returns:
# * A list of substrings that contain only lower-case English vowels but
#   include all five vowels (e.g.
#       ( "aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou" )
#   ) or an empty list if no such substrings exist within the provided string
################################################################################
sub comprehensive_vowel_substrings{
    my $string = shift();

    my $length = length($string);
    my $substring;
    my @substrings;

    # Loop over every starting position that is
    # followed by at least five characters
    for my $start (0 .. $length - 5){
        # Loop over every substring of at least five
        # characters from the starting position
        for my $substr_len (5 .. $length - $start){
            $substring = substr($string, $start, $substr_len);

            # If the string consists only of vowels and
            # contains each vowel at least once, store it
            push(@substrings, $substring)
                if(
                    $substring =~
                        m/(?=^[aeiou]*$)(?=.*a)(?=.*e)(?=.*i)(?=.*o)(?=.*u)/
                );
        }
    }

    return(@substrings);

}



