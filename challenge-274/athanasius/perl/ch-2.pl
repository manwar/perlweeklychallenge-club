#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more "timetable strings" are entered as unnamed arguments on the
   command-line. Each timetable string contains a service-interval, an hour-
   offset, and a trip-duration, separated by whitespace (with optional commas).

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<timetables> ...]
  perl $0

    [<timetables> ...]    Timetable-strings, e.g., "12 11 41" "15 5 35"
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 274, Task #2: Bus Route (Perl)\n\n";
}

#-------------------------------------------------------------------------------
package Route
#-------------------------------------------------------------------------------
{
    use Class::Accessor 'antlers';

    has interval => ( is => 'ro', isa => 'Num' );
    has offset   => ( is => 'ro', isa => 'Num' );
    has duration => ( is => 'ro', isa => 'Num' );

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub next_start
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($self, $current_time) = @_;

        my  $time  = $self->offset;
            $time += $self->interval while $time < $current_time;

        return $time;
    }

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub next_arrival
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($self, $leave_time) = @_;

        return $leave_time + $self->duration;
    }
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $routes = parse_timetables( \@ARGV );

        printf "Input:  [ %s ]\n", join ', ', map { sprintf '[%d, %d, %d]',
                $_->interval, $_->offset, $_->duration } @$routes;

        my $leave_times = find_leave_times( $routes );

        printf "Output: [ %s ]\n", join ', ', @$leave_times;
    }
}

#-------------------------------------------------------------------------------
sub find_leave_times
#-------------------------------------------------------------------------------
{
    my ($routes) = @_;
    my  @leave_times;

    for my $current_time (0 .. 59)
    {
        my ($min_route, $min_start, $min_arrival) =
            find_min_start( $routes, $current_time );

        for my $i (0 .. $#$routes)
        {
            next if $i == $min_route;

            my $start = $routes->[ $i ]->next_start( $current_time );

            if ($start > $min_start)
            {
                my $arrival = $routes->[ $i ]->next_arrival( $start );

                if ($arrival < $min_arrival)
                {
                    push @leave_times, $current_time;
                    last;
                }
            }
        }
    }

    return \@leave_times;
}

#-------------------------------------------------------------------------------
sub find_min_start
#-------------------------------------------------------------------------------
{
    my ($routes, $current_time) = @_;

    my  $min_route   = 0;
    my  $min_start   = $routes->[ 0 ]->next_start( $current_time );
    my  $min_arrival = $routes->[ 0 ]->next_arrival( $min_start );

    for my $i (1 .. $#$routes)
    {
        my $start_time = $routes->[ $i ]->next_start( $current_time );

        if    ($start_time <  $min_start)
        {
            $min_route   = $i;
            $min_start   = $start_time;
            $min_arrival = $routes->[ $i ]->next_arrival( $min_start );
        }
        elsif ($start_time == $min_start)
        {
            my $arrival  = $routes->[ $i ]->next_arrival( $min_start );

            if ($arrival < $min_arrival)
            {
                $min_route   = $i;
                $min_start   = $start_time;
                $min_arrival = $arrival;
            }
        }
    }

    return ($min_route, $min_start, $min_arrival);
}

#-------------------------------------------------------------------------------
sub parse_timetables
#-------------------------------------------------------------------------------
{
    my ($timetables) = @_;
    my  @routes;

    for my $timetable (@$timetables)
    {
        $timetable =~ / ^ \s* (\d+) \,? \s+ (\d+) \,? \s+ (\d+) \s* $ /x
                          or error( qq[Invalid input timetable "$timetable"] );

        my ($interval, $offset, $duration) = @{ ^CAPTURE };

        0 <  $interval    or error( qq["$interval" is not a valid interval] );
        0 <= $offset < 60 or error( qq["$offset" is not a valid offset] );

        push @routes, Route->new( { interval => $interval,
                                    offset   => $offset,
                                    duration => $duration } );
    }

    return \@routes;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $timetables_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $timetables_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @timetables  = split / \; \s+ /x, $timetables_str;
        my $routes      = parse_timetables( \@timetables );
        my $leave_times = find_leave_times( $routes );
        my $expected    = parse_expected( $expected_str );

        is_deeply $leave_times, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub parse_expected
#-------------------------------------------------------------------------------
{
    my ($expected_str) = @_;
    my  @expected;

    for my $s (split / \s+ /x, $expected_str)
    {
        if ($s =~ / ^ (\d+) \- (\d+) $ /x)
        {
            push @expected, $1 .. $2;
        }
        else
        {
            push @expected, $s;
        }
    }

    return \@expected;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1  |12 11 41; 15 5 35                  |36-47
Example 2  |12  3 41; 15 9 35; 30 5 25         |0-3 25-27 40-51 55-59
One route 1|12  3 41                           |
One route 2|12  3 41; 12 3 41                  |
Longer     |12  3 42; 12 3 41                  |
Example 1a |12 11 41; 15 5 35; 15 5 36         |36-47
Example 2a |12  3 41; 15 9 35; 30 5 25; 15 9 36|0-3 25-27 40-51 55-59
