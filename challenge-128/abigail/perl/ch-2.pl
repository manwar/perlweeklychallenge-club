#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util qw [max];

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#
# The input is assumed to consist of two lines: the first with arrival
# times, the second one with departure times.
#

#
# One way of solving this is to scan over the arrivals and departures,
# keeping a running count of platforms required, adding 1 for an arrival,
# and subtracting 1 for a departure. However, this requires the times
# to be sorted, and we are not given that the points are. Sorting would
# require Omega (N log N) time.
#
# Alternatively, we could put the times the trains are in the station
# in an interval tree, or a segment tree, and perform stabbing queries
# with each of the arrival points. But building either tree requires
# Omega (N log N) time.
#
# Instead, we will solve the problem in linear time, taking advantage
# there are only a fixed number of minutes in a day. We start with an
# array of 1440 (the number of minutes in a day) 0s. Then, for each
# train, we add 1 for each of the minutes the train stays at the station
# (if the departure time is before the arrival time, we assume the
# train is at the station during midnight, and use the appropriate minutes).
# If we have processed each train, we find the maximum in the array.
#
# This obviously only takes O (N) time.
#
# Assumptions:
#   - If train A departures at time X, while train B arrives at time X,
#     the cannot share the same platform.
#   - There is minimum distance between trains; that is, if train A
#     leaves a platform at time X, train B can arrive at the platform
#     at time X + 1.
#   - No two trains can share a platform. Either the platforms are 
#     short, or the trains are long.
#

my @arrivals   = map {[split /:/]} <> =~ /[0-9][0-9]:[0-9][0-9]/g;
my @departures = map {[split /:/]} <> =~ /[0-9][0-9]:[0-9][0-9]/g;

my @trains = (0) x (24 * 60);

foreach my $i (keys @arrivals) {
    my $arrival   = 60 * $arrivals   [$i] [0] + $arrivals   [$i] [1];
    my $departure = 60 * $departures [$i] [0] + $departures [$i] [1];
    my @minutes;
    if ($arrival <= $departure) {
        #
        # Train arrives and leaves before midnight.
        #
        @minutes = $arrival .. $departure;
    }
    else {
        #
        # Train arrives before midnight, leaves after midnight.
        #
        @minutes = (0 .. $departure, $arrival .. (24 * 60 - 1));
    }
    $trains [$_] ++ for @minutes;
}

say max @trains;

__END__
