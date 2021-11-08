#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @SEDOLs = (
    # Given cases
    "2936921",
    "1234567",
    "B0YBKL9",

    # Additional test cases
    "ZZZZZZ0",
    "ABCDEF0"
);
my $SEDOL;

foreach $SEDOL (@SEDOLs){
    print("Input: \$SEDOL = '", $SEDOL, "'\n");
    print("Output: ", is_valid_SEDOL_number($SEDOL), "\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether a string contains a valid SEDOL number
# Takes one argument:
# * A string of seven characters that comprise a SEDOL number WITH the check
#   digit- this must consist of exactly seven digits or upper-case consonants
# Returns:
# * 1 if the string is a valid SEDOL number
# * 0 if the string is not a valid SEDOL number
# NOTE: This function does not differentiate between mismatched check digits
# and strings that may be invalid SEDOL numbers for other reasons
################################################################################
sub is_valid_SEDOL_number{
    my $SEDOL = shift();

    # Get the check digit
    my $check = compute_SEDOL_check_digit(substr($SEDOL, 0, 6));

    # See if it's defined and  matches
    # what's in the supplied string
    return(1)
        if(
            defined($check)
            &&
            ($check eq substr($SEDOL, 6, 1))
        );

    return(0);

}



################################################################################
# Calculate the check digit that's associated with a SEDOL number
# Takes one argument:
# * A string of six characters that comprise a SEDOL number WITHOUT the check
#   digit- this must consist of exactly six digits or upper-case consonants
# Returns on success:
# * The check digit calculated from the string provided
# Returns on error:
# * undef if the string does not contain a valid checksum-less SEDOL number
################################################################################
sub compute_SEDOL_check_digit{
    my $unchecked_SEDOL = shift();

    my @weights = (1, 3, 1, 7, 3, 9);
    my $i = 0;
    my $sum = 0;

    # Require six characters, digits and
    # upper-case consonants only
    unless($unchecked_SEDOL =~ m/^[0-9B-DF-HJ-NP-TV-Z]{6}$/){
        return(undef);
    }

    foreach(split("", $unchecked_SEDOL)){
        $sum +=
            $weights[$i++]
            *
            # 'A' (which we don't use...) has an
            # ordinal value of 65 so we subtract
            # to give letters effective values
            # from 10 upward
            ($_ =~ m/\d/ ? $_ : ord($_) - 55);
    }

    return((10 - $sum % 10) % 10);

}



