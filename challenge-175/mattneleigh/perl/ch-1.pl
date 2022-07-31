#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my $year = 2022;

print("\n");
printf(
    "In the year %04d, the last Sundays of the month are:\n%s\n\n",
    $year,
    join("\n", last_sundays_in_year($year))
);

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the dates of the last Sundays of each month in a specified year
# after 1000
# Takes one argument:
# Returns on success:
# * A list of dates of the last Sundays of the month in the specified year, in
#   ISO 8601 format (i.e. YYYY-MM-DD)
# Returns on error:
# * undef if the specified year is less than 1000
################################################################################
sub last_sundays_in_year{
    use Time::Local;
    use constant SECONDS_PER_DAY  => 86400;
    use constant SECONDS_PER_WEEK => 604800;

    my $year = int(shift());

    # Not dealing with anything earlier than 1000
    # due to the vagaries of timegm();
    # timegm_modern() doesn't seem to be available
    # on most of my systems, so eh...
    return(undef)
        if($year < 1000);

    my $time;
    my @time_fields;
    my @dates;

    # Seconds since the start of the epoch at
    # 00:01:00 GMT on January 1 in the specified
    # year
    $time = timegm(0, 1, 0, 1, 0, $year);
    @time_fields = gmtime($time);

    # Advance $time to the first Sunday AFTER
    # New Year's Day (even if NYD is itself a
    # Sunday)
    $time += (7 - $time_fields[6]) * SECONDS_PER_DAY;

    # Loop until we've passed the end of the
    # specified year
    $year -= 1900;
    while($time_fields[5] == $year){
        my @prev_time_fields = @time_fields;

        # Advance the time by a week
        $time += SECONDS_PER_WEEK;
        @time_fields = gmtime($time);

        if($time_fields[4] != $prev_time_fields[4]){
            # We changed months... store the previous
            # Sunday
            push(
                @dates,
                sprintf(
                    "%04d-%02d-%02d",
                    $prev_time_fields[5] + 1900,
                    $prev_time_fields[4] + 1,
                    $prev_time_fields[3],
                )
            );
        }
    }

    return(@dates);

}



