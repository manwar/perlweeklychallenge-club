#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @years = (
    # Additional test cases
    2000,
    2015,

    # Given case
    2023
);

print("\n");
foreach my $year (@years){
    printf(
        "Input: \$year = %d\nOutput: %d\n\n",
        $year,
        number_of_friday_the_thirteenths_in_calendar_year($year)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the number of Friday the 13th's in a specified calendar year
# Takes one argument:
# * The year to examine, which must be in the range of 1753 to 9999, inclusive
# Returns on success:
# * The number of Friday the 13ths in the specified calendar year, which will
#   be 1, 2, or 3
# Returns on error:
# * undef if the year is not within the range specified above
################################################################################
sub number_of_friday_the_thirteenths_in_calendar_year{
    use Time::Local qw(timegm);

    my $year = int(shift());

    return(undef)
        if(($year < 1753) || ($year > 9999));
    $year -= 1900;

    # It's a bad idea to do one's own math regarding
    # dates.  Let's do it anyway...

    # Get the epoch time for 00:01:00 on 1 January
    # of the specified year
    my $timegm = timegm(0, 1, 0, 1, 0, $year);
    my @gmtime = gmtime($timegm);
    my $friday_thirteenths = 0;

    # Advance to the first Friday of the year:
    $timegm +=
        $gmtime[6] == 6 ?
        # 1/1 is a Saturday; add six days
        518400
        :
        # 1/1 is not a Saturday; add the time from then
        # until the first Friday (which may be zero)
        86400 * (5 - $gmtime[6]);

    # Advance through all Fridays while we're still
    # in the specified year
    while($gmtime[5] == $year){
        # See if this Friday is a 13th
        $friday_thirteenths++
            if($gmtime[3] == 13);
        # Add the number of seconds per week
        $timegm += 604800;
        @gmtime = gmtime($timegm);
    }

    return($friday_thirteenths);

}



