#!/usr/bin/perl

use strict;
use warnings;

use Time::Local;

################################################################################
# Begin main execution
################################################################################

my @birthday_dates = (
    "2021/09/18",
    "1975/10/10",
    "1967/02/14"
);
my $birthday_date;
my $reference_date = "2021/09/22";

foreach $birthday_date (@birthday_dates){
    print("Input:  $birthday_date\n");
    print("  With reference date $reference_date:\n");
    printf(
        "    Output: %s\n",
        join(
            ", ",
            birthday_mirror($birthday_date, $reference_date)
        )
    );
    print("  With current date:\n");
    printf(
        "    Output: %s\n\n",
        join(
            ", ",
            birthday_mirror($birthday_date)
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a birthdate and an optional reference date, calculate the mirror dates
# for same- the date before the birthdate and after the reference date that
# correspond to the length of the time interval between the two dates.  If no
# reference date is specified, the current date will be used.
# Takes two arguments:
# * A string defining a birthdate, consisting solely of the date itself in the
#   format YYYY/MM/DD
# * An optional string defining a reference date, subject to the same format
#   requirements as the birthdate; if this argument is omitted, the current
#   date, according to the local system clock, will be used
# Returns:
# * A list with the following members:
#   - A string containing the date BEFORE the birth date corresponding to the
#     length of time elapsed between the birth date and the reference date
#   - A string containing the date AFTER the reference date corresponding to
#     the length of time elapsed between the birth date and the reference date;
#     as noted above, if no reference date is specified, the current date will
#     be used
# NOTE: This function requires that the system correctly handle negative time
# values with respect to the start of the UNIX epoch; this is not mandated by
# the POSIX standard, but in practice most modern systems support this
################################################################################
sub birthday_mirror{
    my $birthday = shift();
    my $reference_date = shift();

    my @time_values;
    my $delta;

    # Calculate the epoch time at 12:00:00 on
    # the specified birthdate; noon is used
    # instead of midnight so leap seconds
    # won't push the time into the wrong day-
    # for reasonable human lifespans,
    # anyway...
    $birthday = noon_on_date($birthday);

    # Calculate the epoch time at 12:00:00
    # on the reference date
    if(defined($reference_date)){
        $reference_date = noon_on_date($reference_date);
    } else{
        # No reference date defined; use the
        # current date, making sure to pull the
        # time from the system clock only once
        $reference_date = time();
        @time_values = localtime($reference_date);
        $reference_date -= (
            ($time_values[2] - 12) * 3600
            +
            $time_values[1] * 60 
            +
            $time_values[0]
        );
    }

    # Difference (delta) between the
    # reference date and the birth date
    $delta = $reference_date - $birthday;

    # Subtract the delta from the birth date
    @time_values = localtime($birthday - $delta);
    $birthday = sprintf(
        "%4d/%02d/%02d",
        $time_values[5] + 1900,
        $time_values[4] + 1,
        $time_values[3]
    );

    # Add the delta to the reference date
    @time_values = localtime($reference_date + $delta);
    $reference_date = sprintf(
        "%4d/%02d/%02d",
        $time_values[5] + 1900,
        $time_values[4] + 1,
        $time_values[3]
    );

    return($birthday, $reference_date);

}



################################################################################
# Calculate the UNIX epoch time in seconds at noon (12:00:00 local system time)
# on a specified date
# Takes one argument:
# * A string defining a date, consisting solely of the date itself in the
#   format YYYY/MM/DD
# Returns:
# * The number of seconds from the start of the UNIX epoch to noon on the
#   specified date, in local system time; if this time is before the start of
#   the epoch, the value returned will be negative
# NOTE: This function requires that the system correctly handle negative time
# values with respect to the start of the UNIX epoch; this is not mandated by
# the POSIX standard, but in practice most modern systems support this
################################################################################
sub noon_on_date{
    my $date = shift();

    my @time_values;

    @time_values = ($date =~ m/^(\d{4})\/(\d{2})\/(\d{2})$/);

    # timelocal() is from Time::Local
    return(
        timelocal(
            0, 0, 12, $time_values[2], $time_values[1] - 1, $time_values[0]
        )
    );

}



