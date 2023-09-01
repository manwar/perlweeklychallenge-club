#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @passenger_lists = (
    [ "7868190130M7522", "5303914400F9211", "9273338290F4010" ],
    [ "1313579440F2036", "2921522980M5644" ]
);

print("\n");
foreach my $passenger_list (@passenger_lists){
    printf(
        "Input: \@list = (%s)\nOutput: %d\n\n",
        join(", ", @{$passenger_list}),
        count_senior_citizens(@{$passenger_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of passenger detail records of the format "9999999999A1122"
# (where '9' denotes the passenger's phone number, 'A' the passenger's sex, '1'
# the passenger's age, and '2' the passenger's seat number) determine how many
# of the passengers are senior citizens (age 60 or greater)
# Takes one argument:
# * A list of passenger records to examine
# Returns
# * The number of senior citizens' records contained in the list
################################################################################
sub count_senior_citizens{

    my $count = 0;

    foreach my $pax_details (@ARG){
        # Passenger age is in a two-character field
        # at characters 12 (index 11)
        $count++
            if(substr($pax_details, 11, 2) >= 60);
    }

    return($count);

}



