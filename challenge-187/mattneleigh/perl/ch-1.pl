#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @itineraries = (
    {
        Foo => [ "12-01", "20-01" ],
        Bar => [ "15-01", "18-01" ]
    },
    {
        Foo => [ "02-03", "12-03" ],
        Bar => [ "13-03", "14-03" ]
    },
    {
        Foo => [ "02-03", "12-03" ],
        Bar => [ "11-03", "15-03" ]
    },
    {
        Foo => [ "30-03", "05-04" ],
        Bar => [ "28-03", "02-04" ]
    }
);

print("\n");
foreach my $itinerary (@itineraries){
    my $days = days_of_overlap($itinerary->{Foo}, $itinerary->{Bar});

    printf(
        "Input: Foo => SD: '%s' ED: '%s'\n" .
        "       Bar => SD: '%s' ED: '%s'\n" .
        "Output: %d day%s\n\n",
        $itinerary->{Foo}[0], $itinerary->{Foo}[1],
        $itinerary->{Bar}[0], $itinerary->{Bar}[1],
        $days,
        ($days == 1 ? "" : "s")
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine how many days of overlap there are in two travel itineraries; each
# itinerary must consist of a ref to an array of two dates in the format DD-MM
# Takes two arguments:
# * A ref to the first itinerary (e.g. [ "30-03", "05-04" ])
# * A ref to the second itinerary (e.g. [ "28-03", "02-04" ])
# Returns:
# * The number of days of overlap between the two itineraries
# NOTE: Both itineraries must lie entirely within the same calendar year; it is
# assumed that this is never a leap year
################################################################################
sub days_of_overlap{
    use Time::Local;
    use List::Util qw(min max);

    my @times;
    my $overlap;

    # Convert the itinerary dates to seconds since
    # the start of the UNIX epoch
    foreach(@ARG){
        my $list = [];

        foreach(@{$ARG}){
            my ($d, $m) = split(/-/, $_);

            # Use 2021 for the year because we know it's
            # not a leap year
            push(@{$list}, timegm(0, 0, 0, $d, $m - 1, 2021));
        }

        push(@times, $list);
    }

    # Compute the overlap in seconds
    $overlap =
        min($times[0][1], $times[1][1])
        -
        max($times[0][0], $times[1][0]);

    if($overlap < 0){
        # Overlap less than zero- no overlap at all
        return(0);
    } else{
        # Zero or greater- divide by the number of
        # seconds in a day, then add one
        return($overlap / 86400 + 1);
    }

}



