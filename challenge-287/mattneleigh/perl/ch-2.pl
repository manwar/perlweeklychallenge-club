#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    # Given cases
    "1",
    "a",
    ".",
    "1.2e4.2",
    "-1.",
    "+1E-8",
    ".44",

    # Additional test cases
    "-0.37",
    "+.50",
    "-123.45E+6"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: %s\n\n",
        $string,
        is_valid_number($string) ?
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
# Given a string, determine whether it contains a valid number.  A valid number
# consists of the following:
#
# * An Integer Number followed by an optional Exponent
#     or
# * A Decimal Number followed by an optional Exponent
#
# An Integer Number is simply an uninterrupted sequence of digits (e.g. "123" )
# 
# Decimal Numbers are defined as follows:
# * Digits followed by a dot '.' (e.g. "123." )
# * Digits followed by a dot '.' followed by digits (e.g. "123.45")
# * A dot '.' followed by digits (e.g. ".45" )
#
# Numbers of either type may be preceded by an optional sign ('-' or '+')
# 
# An Exponent is defined as 'e' or 'E' followed by a required sign ('-' or '+')
# and an integer number (e.g. "E+6" )
#
# Takes one argument:
# * A string containing the alleged number to verify (e.g. "-123.45E+6")
# Returns:
# * 0 if the string does not contain a valid number
# * 1 if the string contains a valid number
###############################################################################
sub is_valid_number{
    my $alleged_number = shift();

    # Check for an invalid number ahead of a possible
    # exponent...
    return(0)
        unless($alleged_number =~ m/^[+-]?(\d+\.?\d*|\.\d+)/g);

    # If that was the whole string, it was a valid
    # number...
    return(1)
        if(length($alleged_number) == pos($alleged_number));

    # There was still more to parse- check for an
    # invalid exponent
    return(0)
        unless($alleged_number =~ m/\G[Ee][+-]\d+$/g);

    # Got here- valid number with exponent
    return(1);

}



