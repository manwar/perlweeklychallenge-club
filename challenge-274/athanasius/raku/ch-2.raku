use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 274
=========================

TASK #2
-------
*Bus Route*

Submitted by: Peter Campbell Smith

Several bus routes start from a bus stop near my home, and go to the same stop
in town. They each run to a set timetable, but they take different times to get
into town.

Write a script to find the times - if any - I should let one bus leave and catch
a strictly later one in order to get into town strictly sooner.

An input timetable consists of the service interval, the offset within the hour,
and the duration of the trip.

Example 1

  Input: [ [12, 11, 41], [15, 5, 35] ]
  Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]

  Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11,
  23, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5
  minutes past (5, 20, ...) and takes 35 minutes.

  At 45 minutes past the hour I could take the route 1 bus at 47 past the hour,
  arriving at 28 minutes past the following hour, but if I wait for the route 2
  bus at 50 past I will get to town sooner, at 25 minutes past the next hour.

Example 2

  Input: [ [12, 3, 41], [15, 9, 35], [30, 5, 25] ]
  Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
          51, 55, 56, 57, 58, 59 ]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more "timetable strings" are entered as unnamed arguments on the
   command-line. Each timetable string contains a service-interval, an hour-
   offset, and a trip-duration, separated by whitespace (with optional commas).

=end comment
#===============================================================================

use Test;

subset Interval of Int where 0 <  *;
subset Offset   of Int where 0 <= * < 60;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 274, Task #2: Bus Route (Raku)\n".put;
}

#-------------------------------------------------------------------------------
class Route
#-------------------------------------------------------------------------------
{
                                                   # All measurements in minutes
    has Interval $.interval is required;           #   Service interval
    has Offset   $.offset   is required;           #   Offset within the hour
    has UInt     $.duration is required;           #   Duration of the trip

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    method next-start( Offset:D $current-time --> UInt:D )
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my UInt $time  = $!offset;
                $time += $!interval while $time < $current-time;

        return $time;
    }

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    method next-arrival( UInt:D $leave-time --> UInt:D )
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        return $leave-time + $!duration;
    }
}

#===============================================================================
multi sub MAIN
(
    #| Timetable-strings, e.g., "12 11 41" "15 5 35"

    *@timetables where { .elems > 0 }
)
#===============================================================================
{
    my Route @routes = parse-timetables( @timetables );

    "Input:  [ %s ]\n".printf:
        @routes.map(
                     { '[%d, %d, %d]'.sprintf: .interval, .offset, .duration }

                   ).join: ', ';

    my Offset @leave-times = find-leave-times( @routes );

    "Output: [ %s ]\n".printf: @leave-times.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-leave-times( List:D[Route:D] $routes --> List:D[Offset:D] )
#-------------------------------------------------------------------------------
{
    my Offset @leave-times;

    for 0 ..^ 60 -> Offset $current-time
    {
        my UInt ($min-route, $min-start, $min-arrival) =
                 find-min-start( $routes, $current-time );

        for 0 .. $routes.end -> UInt $i
        {
            next if $i == $min-route;

            my UInt $start = $routes[ $i ].next-start( $current-time );

            if $start > $min-start
            {
                my UInt $arrival = $routes[ $i ].next-arrival( $start );

                if $arrival < $min-arrival
                {
                    @leave-times.push: $current-time;
                    last;
                }
            }
        }
    }

    return @leave-times;
}

#-------------------------------------------------------------------------------
sub find-min-start
(
    List:D[Route:D] $routes,
    Offset:D        $current-time
--> List:D[UInt:D]
)
#-------------------------------------------------------------------------------
{
    my UInt $min-route   = 0;
    my UInt $min-start   = $routes[ 0 ].next-start( $current-time );
    my UInt $min-arrival = $routes[ 0 ].next-arrival( $min-start );

    for 1 .. $routes.end -> UInt $i
    {
        my UInt $start-time = $routes[ $i ].next-start( $current-time );

        if    $start-time <  $min-start
        {
            $min-route   = $i;
            $min-start   = $start-time;
            $min-arrival = $routes[ $i ].next-arrival( $min-start );
        }
        elsif $start-time == $min-start
        {
            my UInt $arrival = $routes[ $i ].next-arrival( $min-start );

            if $arrival < $min-arrival
            {
                $min-route   = $i;
                $min-start   = $start-time;
                $min-arrival = $arrival;
            }
        }
    }

    return $min-route, $min-start, $min-arrival;
}

#-------------------------------------------------------------------------------
sub parse-timetables( List:D[Str:D] $timetables --> List:D[Route:D] )
#-------------------------------------------------------------------------------
{
    my Route @routes;

    for @$timetables -> Str $timetable
    {
        $timetable ~~ / ^ \s* (\d+) \,? \s+ (\d+) \,? \s+ (\d+) \s* $ /
                          or error( qq[Invalid input timetable "$timetable"] );

        my Int ($interval, $offset, $duration) = $/.map: { .Int };

        0 <  $interval    or error( qq["$interval" is not a valid interval] );
        0 <= $offset < 60 or error( qq["$offset" is not a valid offset] );

        @routes.push: Route.new: :$interval, :$offset, :$duration;
    }

    return @routes;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $timetables-str, $expected-str) =
                $line.split: / \| /;

        for     $test-name, $timetables-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str    @timetables  = $timetables-str.split: / \; \s+ /;
        my Route  @routes      = parse-timetables( @timetables );
        my Offset @leave-times = find-leave-times( @routes );
        my Offset @expected    = parse-expected( $expected-str );

        is-deeply @leave-times, @expected, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub parse-expected( Str:D $expected-str --> List:D[Offset:D] )
#-------------------------------------------------------------------------------
{
    my Offset @expected;

    for $expected-str.split( / \s+ /, :skip-empty ) -> Str $s
    {
        if $s ~~ / ^ (\d+) \- (\d+) $ /
        {
            my UInt ($begin, $end) = $/.map: { .Int };

            @expected.push: |($begin .. $end);
        }
        else
        {
            @expected.push: $s.Int;
        }
    }

    return @expected;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1  |12 11 41; 15 5 35                  |36-47
        Example 2  |12  3 41; 15 9 35; 30 5 25         |0-3 25-27 40-51 55-59
        One route 1|12  3 41                           |
        One route 2|12  3 41; 12 3 41                  |
        Longer     |12  3 42; 12 3 41                  |
        Example 1a |12 11 41; 15 5 35; 15 5 36         |36-47
        Example 2a |12  3 41; 15 9 35; 30 5 25; 15 9 36|0-3 25-27 40-51 55-59
        END
}

################################################################################
