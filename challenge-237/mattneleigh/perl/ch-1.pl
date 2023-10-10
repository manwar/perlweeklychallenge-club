#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @dates = (
    [ 2024,  4, 3, 2 ],
    [ 2025, 10, 2, 4 ],
    [ 2026,  8, 5, 3 ],
);

print("\n");
foreach my $date (@dates){
    printf(
        "Input: Year = %4d, Month = %2d, Weekday of month = %2d, " .
        "day of week = %1d\nOutput: %d\n\n",
        @{$date},
        determine_date_from_week_count(@{$date})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine what day of the month a day occurs when specified by year, month,
# day of week, and week count within the specified month
# Takes four arguments:
# * The specified year
# * The specified month (1-12 --> January-December)
# * The week within the month (1-5)
# * The specified day of the week (1-7 --> Mon-Sun)
# Returns on success:
# * The date of the specified day in the specified week within the specified
#   month
# Returns on error:
# * 0 if the specified day within the specified week is not actually within the
#   specified month
# * undef if the specified arguments define an invalid date or the calcualted
#   date is outside the range of the Gregorian calendar
################################################################################
sub determine_date_from_week_count{
    use Time::Local;

    # Seconds per day
    use constant SPD => 86400;

    # Sanity checks
    return(undef)
        if(
            # Test for valid month
            ($ARG[1] < 1) || ($ARG[1] > 12)
            ||
            # Test for valid week in month
            ($ARG[2] < 1) || ($ARG[2] > 5)
            ||
            # Test for valid day of week
            ($ARG[3] < 1) || ($ARG[3] > 7)
            ||
            # Test whether we have a date roughly within
            # the Gregorian calendar; calculated date will
            # be confirmed later
            (($ARG[0] < 1582) || (($ARG[0] == 1582) && ($ARG[1] < 10)))
        );

    # Switch Sunday from 7 to 0 to match the values
    # used by the time functions
    my $day_spec = $ARG[3] == 7 ? 0 : $ARG[3];
    my $day_first;
    my $month;

    # Start with noon on the first day of the month
    my $time = timegm(
        0, 0, 12, 1, $ARG[1] - 1, $ARG[0]
    );

    # Determine what day of the week the first is
    (undef, undef, undef, undef, undef, undef, $day_first, undef, undef) =
        gmtime($time);

    # Determine the when the first instance of the
    # specified day of the week occurs and adjust
    # $time accordingly
    if($day_spec < $day_first){
        # It's in the second week
        $time += SPD * ((6 - $day_first) + ($day_spec + 1));
    } else{
        # It's in the first week
        $time += SPD * ($day_spec - $day_first);
    }

    # Skip ahead the specified number of weeks
    $time += SPD * 7 * ($ARG[2] - 1);

    # Determine the month and day associated with
    # the calculated time...
    (undef, undef, undef, $day_spec, $month, undef, undef, undef, undef) =
        gmtime($time);

    # See if the calculated date is in the
    # specified month:
    if($month == ($ARG[1] - 1)){
        # It is...
        # Final Gregorian calendar sanity check on
        # the calculated date (years and months
        # before this have already been filtered out)
        return(undef)
            if(($ARG[0] == 1582) && ($ARG[0] == 10) && ($day_spec < 15));

        # Return the calculated day
        return($day_spec);
    } else{
        # It isn't; return 0
        return(0);
    }

}



