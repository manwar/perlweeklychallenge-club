#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @schedules = (
    [
        [ qw(11:20 14:30) ], # Arrivals
        [ qw(11:50 15:00) ]  # Departures
    ],
    [
        [ qw(10:20 11:00 11:10 12:20 16:20 19:00) ], # Arrivals
        [ qw(10:30 13:20 12:40 12:50 20:20 21:20) ]  # Departures
    ],
    # Additional test cases
    [
        # Arrivals
        [ '09:00', '10:30', '10:45', '17:30', '23:30', '00:00', '00:00' ],
        # Departures
        [ '09:15', '10:50', '11:00', '17:35', '00:10', '00:20', '01:30' ]
    ]
);
my $schedule;

foreach $schedule (@schedules){
    printf(
        "Arrivals:   %5s\n",
        join(", ", @{$schedule->[0]})
    );
    printf(
        "Departures: %5s\n",
        join(", ", @{$schedule->[1]})
    );

    # Specify an "end of business day" of 02:00
    printf(
        "Platforms required: %d\n\n",
        calculate_min_platforms($schedule, 2)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the minimum number of platforms required to accommodate trains
# using a station following a specified schedule
# Takes one required argument and one optional argument:
# * A required schedule of trains arriving and departing at this station, in
#   the form of an array ref containing two parallel arrays, the first for
#   arrival times, and the second for departure times, e.g.:
#   [
#       [ '09:00', '10:30', '10:45', '17:30' ],
#       [ '09:15', '10:50', '11:00', '17:35' ]
#   ]
# * An optional "end of business day" time may be specified as a number of
#   hours (no minutes) past midnight if trains may arrive late- a time after
#   midnight but before this time will be considered part of the previous day's
#   schedule for interval calculation purposes.  This value should be a time
#   when no trains are expected to be at the station for accurate computation
#   of dwell times.  If this is not specified, midnight (an effective value of
#   0) will be used.
# Returns:
# * The number of platforms required to accommodate the maximum number of
#   trains expected to be at this station at one time on the given schedule
################################################################################
sub calculate_min_platforms{
    my $schedule = shift();
    my $EOB = shift();

    # Default "end of business day" is
    # midnight if not otherwise specified
    $EOB = 0
        unless(defined($EOB));

    # The action happens from the inside of
    # this call to the outside- the steps are
    # numbered
    return(
        # 3) Find the length of the longest list of
        # overlaps
        max_list_length(
            # 2) Search the dwell time interval list for
            # overlaps
            find_overlaps(
                # 1) Rearrange the schedule into a list of
                # station dwell time intervals for each train,
                # converting the times into purely numerical
                # values (minutes since midnight) en passant
                map(
                    {
                        [
                            convert_time($schedule->[0][$_], $EOB),
                            convert_time($schedule->[1][$_], $EOB)
                        ]
                    }
                    (0 .. $#{$schedule->[0]})
                )
            ) # End call to find_overlaps()
        ) # End call to max_list_length()

        # 4) Add one because the lists of overlaps
        # we counted don't include the train being
        # overlapped
        + 1
    );

}



################################################################################
# Find the length of the longest array in a list of array references
# Takes one argument:
# * A list of references to arrays
# Returns:
# * The length of the longest array in the list
################################################################################
sub max_list_length{

    my $len;
    my $maxlen = 0;

    foreach(@ARG){
        $len = scalar(@{$_});
        if($len > $maxlen){
            $maxlen = $len;
        }
    }

    return($maxlen);

}



################################################################################
# Convert a time in HH:MM format to a number of minutes since midnight.  The
# time must be in 24-hour format (HH ranges from 0 to 23, with leading zeros
# permitted but not required; MM ranges from 0 to 59, with leading zeros.
# required) with no other characters present.  An "end of business day" time is
# specified as a number of hours (no minutes) past midnight if trains may
# arrive late- a time after midnight but before this time will be considered
# part of the previous day's count of minutes (a time of 01:00 will be
# interpreted as being 1500 minutes past midnight if a value of 3 is specified,
# for example).  This value should be a time when no trains are expected to be
# at the station for accurate computation of dwell times.  If this is not
# desired, a value of 0 (effectively midnight) may be used.
# Takes two arguments
# * A string describing the time to convert (see above)
# * An hour that represents an end of the "business day" after midnight (see
#   above)
# Returns on success:
# * The number of minutes since midnight represented by the time in the
#   supplied string
# Returns on error:
# * undef if the argument(s) does not meet the specifications described above
################################################################################
sub convert_time{
    my $time = shift();
    my $EOB = shift();

    if($time =~ m/^(\d{1,2}):(\d{2})$/ && ($1 < 24) && ($2 < 60)){
        if($EOB && ($1 < $EOB)){
            # Nonzero EOB
            return(1440 + $1 * 60 + $2);
        } else{
            # Zero EOB
            return($1 * 60 + $2);
        }
    } else{
        return(undef);
    }

}



################################################################################
# Find overlaps between numerical intervals in a list
# Takes one argument:
# * A list of refs to intervals- arrays containing two numerical values, which
#   must appear in ascending order (e.g. [1, 5] but not [7, 3])
# Returns:
# * A list of refs to arrays containing the indices of intervals that overlap
#   with the intrval in the corresponding position in the original list.  If no
#   overlaps were found for that interval, the corresponding array in the
#   returned list will be empty.  Note that every overlapping interval will
#   result in each interval's index being stored in the other's overlap array.
#
# Example:
#   @intervals = ( [3, 10], [3, 5], [0, 2], [7, 10], [4, 9] );
#   @overlaps = find_overlaps(@intervals);
#   # @overlaps ==
#   #     ( [ 1, 3, 4 ], [ 0, 4 ], [  ], [ 0, 4 ], [ 0, 1, 3 ] )
#
################################################################################
sub find_overlaps{

    my $i;
    my $j;
    my @overlap_intervals;

    # Set up empty array refs to match the
    # number of intervals we'll be looking at
    @overlap_intervals = map({ [] } (0 .. $#ARG));

    # Loop over intervals from the 1th (as
    # opposed to the 1st) onward
    for $i (1 .. $#ARG){
        # Loop over intervals from the 0th to the
        # (i - 1)th
        for $j (0 .. ($i - 1)){
            # Basically:
            # if(max(beginnings) - min(ends) <= 0)
            if(
                # Maximum of the beginnings of the ranges
                ($ARG[$j][0] > $ARG[$i][0] ? $ARG[$j][0] : $ARG[$i][0])
                - 
                # Minimum of the ends of the ranges
                ($ARG[$j][1] < $ARG[$i][1] ? $ARG[$j][1] : $ARG[$i][1])
                <=
                0
            ){
                # Store each overlapping interval's index
                # in the array corresponding to the other
                push(@{$overlap_intervals[$i]}, $j);
                push(@{$overlap_intervals[$j]}, $i);
            }
        }
    }

    return(@overlap_intervals);

}



