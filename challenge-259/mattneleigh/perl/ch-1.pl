#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @dates = (
    [
        "2018-06-28",
        3,
        [
            "2018-07-03"
        ]
    ],
    [
        "2018-06-28",
        3,
        undef
    ]
);

print("\n");
foreach my $date (@dates){
    printf(
        "\$start_date = %s\n\$offset = %d\n"
        .
        "\$bank_holidays = %s\nOutput: %s\n\n",
        $date->[0],
        $date->[1],
        defined($date->[2]) ?
            sprintf(
                "[\n%s\n                 ]",
                join(
                    "\n",
                    map(
                        "                     " . $_,
                        @{$date->[2]}
                    )
                )
            )
            :
            "undef (none)",
        calculate_offset_business_day($date)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a start date and an offset in days, as well as an optional list of Bank
# Holidays, determine the date that is $offset business days (not weekends, not
# Bank Holidays) after the start date
# Takes one argument:
# * A ref to an array that contains a start date in ISO format, an offset in
#   days, and an optional ref to a list of Bank Holidays, also in ISO format
#   (e.g.
#       [
#           # Start date
#           "2018-06-28",
#
#           # Offset
#           3,
#
#           # Bank holidays; this field should be undef
#           # if not used
#           [
#               "2018-07-03"
#           ]
#       ]
#   )
# Returns:
# * The date of the calculated business day in ISO format (e.g. "2018-07-04" )
################################################################################
sub calculate_offset_business_day{
    use constant secs_per_day => 86400;

    my $date = shift();

    my $base = date_to_gmtime($date->[0]);
    my $offset = $date->[1];
    my @date;
    my @holidays;

    if(defined($date->[2])){
        # Get a sorted list of bank holidays in gmtime
        @holidays = sort(
            { $a <=> $b }
            map(
                {
                    my $gmtime = date_to_gmtime($_);

                    # Only pass along bank holidays that aren't
                    # before our base date
                    $gmtime < $base ?
                    ()
                    :
                    $gmtime;
                }
                @{$date->[2]}
            )
        );
    }

    # Loop while we still have unused offset days
    while($offset){
        # Advance the base date by one day and see
        # what day of the week this is
        $base += secs_per_day;

        # See if this date is a bank holiday...
        if(@holidays && ($base == $holidays[0])){
            # It was- strip the bank holiday from the list
            # and skip ahead to the next date without
            # decrementing the offset
            shift(@holidays);
            next;
        }

        # Skip ahead without decrementing the offset
        # if this is a weekend date
        @date = gmtime($base);
        next
            if(($date[6] == 0) || ($date[6] == 6));

        $offset--;
    }

    # Get date fields for our computed base time
    @date = gmtime($base);

    return(
        sprintf(
            "%04d-%02d-%02d",
            1900 + $date[5],
            1 + $date[4],
            $date[3]
        )
    );

}



################################################################################
# Convert a date in ISO format (YYYY-MM-DD) to the time in seconds since the
# start of the UNIX epoch, GMT
# Takes one argument:
# * The date to convert (e.g. "2018-06-28" )
# Returns:
# * The number of seconds from the start of the UNIX epoch to midnight at the
#   start of the specified date, in GMT (e.g. 1530144000 )
################################################################################
sub date_to_gmtime{
    use Time::Local qw(timegm);

    # Split the input date on hyphens
    my @date = split(/-/, shift());

    # Calculate the seconds since the start of the
    # epoch, in GMT, for midnight on the specified
    # date
    return(
        # Theoretically timegm_modern() would be better
        # here but this is more compatible with older
        # Perl installs...
        timegm(0, 0, 0, $date[2], $date[1] - 1, $date[0] - 1900)
    );

}



