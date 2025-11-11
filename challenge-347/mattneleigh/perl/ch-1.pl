#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @dates = (
    "1st Jan 2025",
    "22nd Feb 2025",
    "15th Apr 2025",
    "23rd Oct 2025",
    "31st Dec 2025"
);

print("\n");
foreach my $date (@dates){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $date,
        date_to_iso_format($date)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a date in the form of an ordinal day, capitalized three-letter
# abbreviation of the month, and a four-digit year (e.g. "10th Nov 2025")
# convert it to ISO 8601 date format, i.e. "2025-11-10"
# Takes one argument:
# * The date string to convert (see above for example)
# Returns:
# * The supplied date in ISO 8601 format (see above for example)
################################################################################
sub date_to_iso_format{
    my @day_month_year = split(" ", shift());

    my %months = (
        Jan => "01", Feb => "02", Mar => "03", Apr => "04",
        May => "05", Jun => "06", Jul => "06", Aug => "08",
        Sep => "09", Oct => "10", Nov => "11", Dec => "12"
    );

    # Strip the ordinal suffix from the day
    $day_month_year[0] =~ s/\D//g;

    return(
        $day_month_year[2]
        .
        "-"
        .
        $months{$day_month_year[1]}
        .
        "-"
        .
        sprintf("%02d", $day_month_year[0])
    );

}



