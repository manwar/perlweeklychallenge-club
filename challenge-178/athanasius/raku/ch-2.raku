use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumption
----------
All calculations are to the nearest whole minute.

Implementation
--------------
Calculations are performed by Raku's native Date and DateTime classes.

=end comment
#==============================================================================

my Real constant $MINUTE  =  1 / 60;
my UInt constant $START   =  9;
my UInt constant $END     = 18;
my UInt constant $BUS-HRS = $END - $START;

enum Weekday « :Monday(1) Tuesday Wednesday Thursday Friday Saturday Sunday »;

my regex TS {
               $<year>   = [ \d ** 4 ]
               '-'
               $<month>  = [ \d ** 2 ]
               '-'
               $<day>    = [ \d ** 2 ]
               \s+
               $<hour>   = [ \d ** 1..2 ]
               ':'
               $<minute> = [ \d ** 2 ]
            };

subset Timestamp of Str where {
                                  $_ ~~ &TS            && 
                                  1 <= $<month>  <= 12 &&
                                  1 <= $<day>    <= 31 &&
                                  0 <= $<hour>   <= 23 &&
                                  0 <= $<minute> <= 59
                              };

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 178, Task #2: Business Date (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Timestamp:D $timestamp,              #= Timestamp, e.g., "2022-08-01 10:30"
    Real:D      $duration where * >= 0   #= Duration in hours
)
#==============================================================================
{
    "Input\n  Timestamp: $timestamp\n  Duration:  $duration hours\n".put;

    $timestamp ~~ &TS;

    my DateTime $dt0 = DateTime.new: year   => $<year>,
                                     month  => $<month>,
                                     day    => $<day>,
                                     hour   => $<hour>,
                                     minute => $<minute>,
                                     second => 0;

    my UInt     $dow   = $dt0.day-of-week;
    my Real     $hours = $dt0.day-fraction * 24;
    my DateTime $dt1   = ((Monday <= $dow <= Friday) &&
                          ($END - $hours) >= ($duration - $MINUTE))
                         ?? same-day( $dt0, $duration )
                         !! advance\( $dt0, $duration, $dow );

    "Output\n  Timestamp: %s %02d:%02d\n".printf:
        $dt1.yyyy-mm-dd, $dt1.hour, $dt1.minute;
}

#------------------------------------------------------------------------------
sub same-day( DateTime:D $dt, Real:D $duration where * >= 0 --> DateTime:D )
#------------------------------------------------------------------------------
{
    my Real $start      =  $dt.day-fraction * 24;
            $start      =  $START if $start < $START;
    my Real $new-time   =  $start +  $duration;
    my UInt $hours      =  $new-time.floor;
    my Real $remainder  = ($new-time - $hours) * 60;
    my UInt $minutes    =  $remainder.floor;

    return DateTime.new: year   => $dt.year,
                         month  => $dt.month,
                         day    => $dt.day,
                         hour   => $hours,
                         minute => $minutes,
                         second => 0;
}

#------------------------------------------------------------------------------
sub advance( DateTime:D $dt, Real:D $duration, UInt:D $dow --> DateTime:D )
#------------------------------------------------------------------------------
{
    my Real $dur-remaining = $duration;

    if 1 <= $dow <= 5 && $dt.hour < $END
    {
        my Real $start = $dt.day-fraction * 24;
                $start = $START if $start < $START;

        $dur-remaining -= $END - $start;
    }

    my Date $date = get-next-day( $dt.Date );

    while ($dur-remaining - $BUS-HRS) > $MINUTE
    {
        $date           = get-next-day( $date );
        $dur-remaining -= $BUS-HRS;
    }

    return same-day( DateTime.new( date => $date ), $dur-remaining );
}

#------------------------------------------------------------------------------
sub get-next-day( Date:D $date --> Date:D )
#------------------------------------------------------------------------------
{
    my UInt $dow   =  $date.day-of-week;
    my UInt $delta = ($dow == Friday  ) ?? 3 !!
                     ($dow == Saturday) ?? 2 !! 1;

    return $date + $delta;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
