#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @phone_numbers = (
    "1-23-45-6",
    "1234",
    "12 345-6789",
    "123 4567",
    "123 456-78"
);

print("\n");
foreach my $phone_number (@phone_numbers){
    printf(
        "Input: \$phone = \"%s\"\nOutput: \"%s\"\n\n",
        $phone_number,
        reformat_telephone_number($phone_number)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a telephone number consisting only of digits, spaces, or dashes,
# reformat it into dash-separated blocks according to the following rules:
# 1) All digits will be grouped into blocks of three (3) except...
# 2) The final four (4) or fewer digits, if any, will be...
#     2a) ...presented as a single block of digits if fewer than four digits
#         remain
#     2b) ...presented as two blocks of two digits if four digits remain
# Takes one argument:
# * The phone number to process (e.g. "123 4567")
# Returns:
# * The phone number reformatted as described above (e.g. "123-45-67")
################################################################################
sub reformat_telephone_number{
    # Grab only the digits from the input
    my @digits = grep(/\d/, split("", shift()));

    my $reformatted = "";

    # Create blocks of three digits, leaving only the
    # last four or fewer digits for later processing
    while(scalar(@digits) > 4){
        $reformatted .= "-"
            if(length($reformatted));
        $reformatted .= join("", splice(@digits, 0, 3));
    }

    # Handle remaining digits, if necessary
    if(scalar(@digits)){
        if(scalar(@digits) == 4){
            # 4 digits
            for(0 .. 1){
                $reformatted .= "-"
                    if(length($reformatted));
                $reformatted .= join("", splice(@digits, 0, 2));
            }
        } else{
            # 1-3 digits
            $reformatted .= "-"
                if(length($reformatted));
            $reformatted .= join("", splice(@digits, 0));
        }
    }

    return($reformatted);

}



