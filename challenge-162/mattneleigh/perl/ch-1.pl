#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ISBNs = (
    # Given case
    "978-0-306-40615-7",

    # Given case, with transposed digits
    "978-0-360-40615-7",

    # Additional test cases
    "978-0-596-00027-1",
    "978-1-119-61162-2"
);
my $ISBN;

print("\n");
foreach $ISBN (@ISBNs){
    my $checksum = calculate_ISBN13_checksum($ISBN);

    printf(
        "%s --> %d%s\n",
        $ISBN,
        $checksum,
        ($checksum == substr($ISBN, -1, 1)) ? "" : " (INVALID!)"
    );
}
print("\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the checksum of an ISBN13 code
# Takes one argument:
# * The string containing the ISBN13 code, which may include hyphens and the
#   checksum if already supplied; only the first 12 digit characters will be
#   examined for the purposes of calculation
# Returns on success:
# * The checksum for the supplied string.  This function does NOT validate an
#   extant checksum if included in the string; doing so is the caller's
#   responsibility.
# Returns on error:
# * undef if there aren't at least 12 digits in the supplied string
################################################################################
sub calculate_ISBN13_checksum{
    my $number = shift();

    my @digits;

    # Strip out anything that isn't
    # a digit
    $number =~ s/\D//g;

    # Make sure we have at least 12
    # digits left...
    return(undef)
        if(length($number) < 12);
    
    @digits = split('', $number);

    # Calculate checksum and return
    return(
        10 - (
            $digits[0]  + 3 * $digits[1] +
            $digits[2]  + 3 * $digits[3] +
            $digits[4]  + 3 * $digits[5] +
            $digits[6]  + 3 * $digits[7] +
            $digits[8]  + 3 * $digits[9] +
            $digits[10] + 3 * $digits[11]
        ) % 10
    );

}



