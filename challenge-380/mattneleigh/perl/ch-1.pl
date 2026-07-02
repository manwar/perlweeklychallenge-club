#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "banana",
    "teestett",
    "aeiouuaa",
    "rhythm",
    "x"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %d\n\n",
        $string,
        minimum_frequency_total($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string consisting of English letters only, determine the sum of the
# instances of the most frequently occurring consonant and vowel therein
# Takes one argument:
# * The string to examine (e.g. "teestett")
# Returns:
# * The sum of the number of instances of the most frequently occurring
#   consonant and vowel within the string (e.g. 7)
################################################################################
sub minimum_frequency_total{
 
    my %consonants;
    my %vowels;

    # Loop over each letter in the string,
    # counting instances of vowels and consonants
    # in separate tables.
    foreach my $letter (split("", shift())){
        if($letter =~ m/[aeiou]/i){
            $vowels{$letter}++;
        } else{
            $consonants{$letter}++;
        }
    }

    return(
        # Sum the consonant and vowel counts
        (
            # Find the consonant with the largest
            # instance count, or use zero if there wasn't
            # one
            (sort({ $a <=> $b } map($consonants{$_}, keys(%consonants))))[-1]
            //
            0
        )
        +
        (
            # Same as above, but for vowels
            (sort({ $a <=> $b } map($vowels{$_}, keys(%vowels))))[-1]
            //
            0
        )
    );

}



