#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

# Tens-place and ones-place numbers that do
# not have an 'e' in them; numbers from
# sixty six to one hundred all have an 'e'
# so just use a limited subset of digits
my @tens = ( 0, 3, 4, 5, 6 );
my @ones = ( 0, 2, 4, 6 );
my @ebans;
my $tens_digit;
my $ones_digit;

# Loop over the tens place digits
foreach $tens_digit (@tens){
    # Loop over the ones place digits
    foreach $ones_digit (@ones){
        if($tens_digit){
            # Tens digit is not zero...
            push(@ebans, $tens_digit . $ones_digit);
        } else{
            # Tens digit is zero...
            push(@ebans, $ones_digit) if($ones_digit);
        }
    }
}

print("\nThe Eban numbers below 100 are:\n");
print(join(", ", @ebans), "\n\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



