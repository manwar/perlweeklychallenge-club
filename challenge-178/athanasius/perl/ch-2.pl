#!perl

###############################################################################
=comment

Perl Weekly Challenge 178
=========================

TASK #2
-------
*Business Date*

Submitted by: Mohammad S Anwar

You are given $timestamp (date with time) and $duration in hours.

Write a script to find the time that occurs $duration business hours after
$timestamp. For the sake of this task, let us assume the working hours is 9am
to 6pm, Monday to Friday. Please ignore timezone too.

For example,

  Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours.
  Then the next business date would be 2022-08-01 14:30.

  Similar if the given timestamp is 2022-08-01 17:00 and the duration is 3.5
  hours.
  Then the next business date would be 2022-08-02 11:30.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
All calculations are to the nearest whole minute.

Implementation
--------------
Calculations are performed by the CPAN module DateTime.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use DateTime;
use Regexp::Common qw( number );
use Try::Tiny;

use enum qw( Monday=1 Tuesday Wednesday Thursday Friday Saturday Sunday );

const my $MINUTE  =>  1 / 60;
const my $START   =>  9;
const my $END     => 18;
const my $BUS_HRS => $END - $START;
const my $USAGE   =>
qq[Usage:
  perl $0 <timestamp> <duration>

    <timestamp>    Timestamp, e.g., "2022-08-01 10:30"
    <duration>     Duration in hours\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 178, Task #2: Business Date (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($dt0, $duration) = parse_command_line();

    printf "Input\n  Timestamp: %s %02d:%02d\n  Duration:  %s hours\n\n",
        $dt0->ymd, $dt0->hour, $dt0->minute, $duration;

    my $dow   = $dt0->day_of_week;
    my $hours = $dt0->hour + ($dt0->minute / 60);
    my $dt1   = ((Monday <= $dow <= Friday) &&
                 ($END - $hours) >= ($duration - $MINUTE))
                ? same_day( $dt0, $duration )
                : advance ( $dt0, $duration, $dow );

    printf "Output\n  Timestamp: %s %02d:%02d\n",
        $dt1->ymd, $dt1->hour, $dt1->minute;
}

#------------------------------------------------------------------------------
sub same_day
#------------------------------------------------------------------------------
{
    my ($dt, $duration) =  @_;

    my  $start      =  $dt->hour + ($dt->minute / 60);
        $start      =  $START if $start < $START;
    my  $new_time   =  $start + $duration;
    my  $hours      =  int( $new_time );
    my  $remainder  = ($new_time - $hours) * 60;
    my  $minutes    =  int( $remainder );
        $remainder -=  $minutes;
    my  $seconds    =  int( $remainder * 60 );

    return DateTime->new(
                            year   => $dt->year,
                            month  => $dt->month,
                            day    => $dt->day,
                            hour   => $hours,
                            minute => $minutes,
                            second => $seconds,
                        );
}

#------------------------------------------------------------------------------
sub advance
#------------------------------------------------------------------------------
{
    my ($dt, $duration, $dow) = @_;
    my  $dur_remaining        = $duration;

    if (1 <= $dow <= 5 && $dt->hour < $END)
    {
        my $start =  $dt->hour + ($dt->minute / 60);
           $start =  $START if $start < $START;

        $dur_remaining -= $END - $start;
    }

    $dt = get_next_day( $dt );

    while (($dur_remaining - $BUS_HRS) > $MINUTE)
    {
        $dt             = get_next_day( $dt );
        $dur_remaining -= $BUS_HRS;
    }

    $dt->set( hour => 0, minute => 0, second => 0 );

    return same_day( $dt, $dur_remaining );
}

#------------------------------------------------------------------------------
sub get_next_day
#------------------------------------------------------------------------------
{
    my ($dt)   =  @_;
    my  $dow   =  $dt->day_of_week;
    my  $delta = ($dow == Friday  ) ? 3 :
                 ($dow == Saturday) ? 2 : 1;

    return $dt->add( days => $delta );
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    my ($timestamp, $duration) = @ARGV;

    my ($year, $month, $day, $hour, $minute) =
        $timestamp =~ / (\d{4}) - (\d{2}) - (\d{2}) \s+ (\d{1,2}) : (\d{2}) /x
                       or error( qq[Timestamp "$timestamp" is invalid] );

    1 <= $month  <= 12 or error( qq["$month" is not a valid month] );
    1 <= $day    <= 31 or error( qq["day" is not a valid day of the month] );
    0 <= $hour   <= 23 or error( qq["$hour" is not a valid hour] );
    0 <= $minute <= 59 or error( qq["$minute" is not a valid minute] );

    my $dt0;

    try
    {
        $dt0 = DateTime->new(
                                year   => $year,
                                month  => $month,
                                day    => $day,
                                hour   => $hour,
                                minute => $minute,
                            );
    }
    catch
    {
        error( 'Invalid date' );
    };

    $duration =~ / ^ $RE{num}{real} $ /x
                   or error( qq["$duration" is not a valid real number] );
    $duration >= 0 or error( 'Negative duration is not supported' );

    return ($dt0, $duration);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
