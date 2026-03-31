#!/usr/bin/env perl

# You are given two events start and end time.

# Write a script to find out if there is a conflict between the two
# events. A conflict happens when two events have some non-empty
# intersection.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub conflict_events {
    use Time::Piece;
    my @event1 = @{ $_[0]->[0] };
    my @event2 = @{ $_[0]->[1] };
    printf
        qq{ Input: \@event1 = ("%s", "%s")\n        \@event2 = ("%s", "%s")\n },
        $event1[0], $event1[1],
        $event2[0], $event2[1];

    my $result = "false";

    my @interval1 = map { Time::Piece->strptime( $_, "%H:%M" ) } @event1;
    my @interval2 = map { Time::Piece->strptime( $_, "%H:%M" ) } @event2;

    $_ += 86400 for @interval1;
    $_ += 86400 for @interval2;
    if ( $interval1[0] > $interval1[1] ) {
        $interval1[0] -= 86400;
    }

    if (     ( $interval1[0] < $interval2[0] )
          && ( $interval1[1] > $interval2[0] ) )
    {
        $result = "true";
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}

sub conflict_events_alt {
    use Date::Interval;
    my @event1 = @{ $_[0]->[0] };
    my @event2 = @{ $_[0]->[1] };
    printf
        qq{ Input: \@event1 = ("%s", "%s")\n        \@event2 = ("%s", "%s")\n },
        $event1[0], $event1[1],
        $event2[0], $event2[1];

    Date::Interval->setDefaultIntervalType($Date::Interval::OPEN_INT);
    my $result = "false";

    my $event1 = Date::Interval->new( $event1[0], $event1[1],
                                      $Date::Interval::LEFT_OPEN_INT );
    my $event2 = Date::Interval->new( $event2[0], $event2[1],
                                      $Date::Interval::RIGHT_OPEN_INT );

    if ( $event1->overlaps($event2) ) {
        diag "overlaps";
        $result = "true";
    }

    printf qq{Output: %s\n}, $result;
    return $result;
}

my @examples = (
                 {  in   => [ [ "10:00", "12:00" ], [ "11:00", "13:00" ] ],
                    out  => "true",
                    name => 'example 1'
                 },
                 {  in   => [ [ "09:00", "10:30" ], [ "10:30", "12:00" ] ],
                    out  => "false",
                    name => 'example 2'
                 },
                 {  in   => [ [ "14:00", "15:30" ], [ "14:30", "16:00" ] ],
                    out  => "true",
                    name => 'example 3'
                 },
                 {  in   => [ [ "08:00", "09:00" ], [ "09:01", "10:00" ] ],
                    out  => "false",
                    name => 'example 4'
                 },
                 {  in   => [ [ "23:30", "00:30" ], [ "00:00", "01:00" ] ],
                    out  => "true",
                    name => 'example 5'
                 },
               );

is( conflict_events( $_->{ in } ), $_->{ out }, $_->{ name } ) for @examples;
