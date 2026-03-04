#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "aa - two vowels and zero consonants",
    "iv - one vowel and one consonant",
    "hello - three vowels and two consonants",
    "aeiou - five vowels and zero consonants",
    "aei - three vowels and zero consonants"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %s\n\n",
        $string,
        verify_claims($string) ? "true" : "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a specifically formatted string that contains a substring as well as
# assertions about the number of vowels and consonants in the substring,
# determine whether the stated claims are true; the string must be formatted
# thus: "<SUBSTRING> - <NUMBER> vowel[s] and <NUMBER> consonant[s]"
# Takes one argument:
# * The string to examine (e.g. "hello - three vowels and two consonants")
# Returns:
# * 1 if the string's claims about itself are true
# * 0 if the string's claims about itself are false (as they would be in the
#   example above)
################################################################################
sub verify_claims{
    # Extract the substring to examine, and the
    # alleged quantities of vowels and consonants
    my ($string, $vowels, $consonants) =
        (shift() =~ m/(\w+) - (\w+) vowels? and (\w+) consonants?/);

    my %quantities = (
        zero => 0, one => 1, two => 2, three => 3, four => 4,
        five => 5, six => 6, seven => 7, eight => 8, nine => 9
    );

    # Convert quantities from verbal to numeric
    $vowels = $quantities{$vowels};
    $consonants = $quantities{$consonants};

    # Loop over each character in the substring,
    # subtracting from the count of vowels or
    # consonants appropriately
    foreach my $char (split("", $string)){
        $char =~ m/[aeiou]/ ? $vowels-- : $consonants--;
    }

    # If either count is nonzero, the allegations
    # were false
    return(
        $vowels || $consonants ?
            0
            :
            1
    );

}



