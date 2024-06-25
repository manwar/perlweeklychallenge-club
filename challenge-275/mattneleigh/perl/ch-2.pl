#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "a1c1e1",
    "a1b2c3d4",
    "b2b",
    "a16z",

    # Additional test cases
    "z1",
    "_123V_456_"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = '%s'\nOuput: '%s'\n\n",
        $string,
        character_advance($string)
    );
}
;

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string of letters (within the English alphabet) and digits, replace
# each digit with the previous letter, advanced by the value of the digit.
# Digits that precede the first letter will be removed from the resulting
# string, while non-letter and non-digit characters will be ignored; if a
# computed character value lies beyond the alphabet, it will be wrapped around
# to the beginning (i.e. "z5" -> "ze").
# Takes one argument:
# * The string to examine (e.g. "a1c1e1")
# Returns:
# * The modified string (e.g. "abcdef")
################################################################################
sub character_advance{
    my @chars = split("", shift());

    my $last_letter = undef;
    my $char_value;

    # Examine each character
    foreach my $i (0 .. $#chars){
        if($chars[$i] =~ m/\d/){
            # This character is a digit
            if(defined($last_letter)){
                # A previous letter was defined- replace
                # the digit with that letter, advanced
                # by the value of the current digit
                $char_value = ord($chars[$last_letter]) + $chars[$i];

                # Wrap around unless we haven't exceeded
                # the bounds of the alphabet
                $char_value -= 26
                    unless(
                        # Lower case
                        (($char_value > 96) && ($char_value < 123))
                        ||
                        # Upper case
                        (($char_value > 64) && ($char_value < 91))
                    );

                # Store the new letter in place of
                # the digit
                $chars[$i] = chr($char_value);
            } else{
                # No previous letter was defined- replace
                # with the empty string
                $chars[$i] = "";
            }
        } elsif($chars[$i] =~ m/[A-Za-z]/){
            # This character is a letter- make a note
            # of its location
            $last_letter = $i;
        }
    }

    return(join("", @chars));

}



