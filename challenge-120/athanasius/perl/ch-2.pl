#!perl

###############################################################################
=comment

Perl Weekly Challenge 120
=========================

TASK #2
-------
*Clock Angle*

Submitted by: Mohammad S Anwar

You are given time $T in the format hh:mm.

Write a script to find the smaller angle formed by the hands of an analog clock
at a given time.

HINT: A analog clock is divided up into 12 sectors. One sector represents 30
degree (360/12 = 30).

Example

 Input: $T = '03:10'
 Output: 35 degree

 The distance between the 2 and the 3 on the clock is 30 degree.
 For the 10 minutes i.e. 1/6 of an hour that have passed.
 The hour hand has also moved 1/6 of the distance between the 3 and the 4,
 which adds 5 degree (1/6 of 30).
 The total measure of the angle is 35 degree.

 Input: $T = '04:00'
 Output: 120 degree

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Note on Output
--------------
Should fractions of a degree be output as decimals or as minutes and seconds?
The issue is simplified by the observation that the smallest fraction is half a
degree. (See below: ma_deg = (hours * 30) + (mins / 60) * 30
                           = (hours * 30) + (mins / 2)
and since hours and mins are both positive integers, ma_deg ends in 0.5° when
the value of mins is odd.) Therefore, whole-number solutions are output as
degrees only; solutions ending in 0.5° are output as both --.5° and --° 30' 0".

Algorithm
---------
Extract hour and mins from T using a regular expression

Let "the axis" be the vertical line passing through points 12 and 6 on the
    clockface

Let ha_deg be the angle, in degrees, between the axis and the hour hand of the
    clock, moving clockwise from the axis to the hour hand
Calculation:
    ha_deg = mins * 60°

Let ma_deg be the angle, in degrees, between the axis and the minute hand of
    the clock, moving clockwise from the axis to the minute hand
Calculation:
    ma_deg = (hours * 30°) + (mins / 60) * 30°

Let hm_deg be the smaller of the two angles, in degrees, between the hour and
    minutes hands of the clock at the specified time
Calculation:
    1. hm_deg = |ha_deg - ma_deg|
    2. IF hm_deg > 180° THEN hm_deg = 360° - hm_deg

Interface
---------
This script was developed and tested under Windows 8.1 (64-bit), with output to
a Command Prompt screen. For proper display of the degree symbol (°), the
Windows active code page is set to 1252 (Latin 1). This is implemented in a
BEGIN block. The original active code page is restored on script completion in
an END block.

=cut
#==============================================================================

use strict;
use warnings;
use utf8;
use Capture::Tiny  qw( capture );
use Const::Fast;
use Regexp::Common qw( number );

use constant CODE_PAGE       => 1252;

const my $DEGREES_PER_CIRCLE =>  360;
const my $HOURS_PER_HALF_DAY =>   12;
const my $MINUTES_PER_HOUR   =>   60;
const my $DEGREES_PER_HOUR   => $DEGREES_PER_CIRCLE / $HOURS_PER_HALF_DAY;
const my $DEGREES_PER_MINUTE => $DEGREES_PER_CIRCLE / $MINUTES_PER_HOUR;
const my $EPSILON            => 1e-12;
const my $USAGE              =>
"Usage:
  perl $0 <T>

    <T>    A time in 12-hour \"hh:mm\" format\n";

#==============================================================================
MAIN:
#==============================================================================
{
    my ($hour, $mins) = parse_command_line();

    printf "Input:  \$T = %02d:%02d\n", $hour, $mins;

    my $ma_deg = $DEGREES_PER_MINUTE *  $mins;
    my $ha_deg = $DEGREES_PER_HOUR   * ($hour + ($mins / $MINUTES_PER_HOUR));

    my $hm_deg = abs( $ha_deg - $ma_deg );
       $hm_deg = $DEGREES_PER_CIRCLE - $hm_deg
                    if $hm_deg > ($DEGREES_PER_CIRCLE / 2);

    my $diff   = $hm_deg - int $hm_deg;

    if     ($diff        < $EPSILON)      # There is no fractional part
    {
        print  "Output: $hm_deg°\n";
    }
    elsif (($diff - 0.5) < $EPSILON)      # Fractional part is 0.5° (i.e., 30')
    {
        printf qq[Output: %.1f° (= %d° 30' 0")\n], $hm_deg, $hm_deg;
    }
    else
    {
        die "\$diff = $diff, stopped";    # Impossible case
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
           or error( "Expected 1 command line argument, found $args" );

    my ($hour, $mins) = $ARGV[ 0 ] =~ / ^ (\d\d) \: (\d\d) $ /x
           or error( 'Invalid time format' );

    # Validate hour

    $hour =~ / ^ $RE{num}{int} $ /x
           or error( qq["$hour" is not a valid integer] );

    0 <  $hour <= 12
           or error( sprintf qq[Hour "%02d" is outside range 1 to 12], $hour );

    # Validate minutes

    $mins =~ / ^ $RE{num}{int} $ /x
           or error( qq["$mins" is not a valid integer] );

    0 <= $mins <  60
           or error( qq[Minutes "$mins" is outside range 0 to 59] );

    return ($hour, $mins);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#==============================================================================
# Initialize and finalize
#==============================================================================
{
    my $code_page;                                           # Active code page

    #--------------------------------------------------------------------------
    BEGIN
    #--------------------------------------------------------------------------
    {
        $| = 1;

        # Facilitate correct display of the degree symbol (°) in the Windows
        # Command Prompt window

        if ($^O =~ /MSWin/i)
        {
            my ($stdout, $stderr, $exit) = capture { system 'chcp' };
            warn $stderr if $stderr || $exit;

            ($code_page) = $stdout =~ /^Active code page: (\d+)\s$/;

            (undef, $stderr, $exit) = capture { system 'chcp', CODE_PAGE };
            warn $stderr if $stderr || $exit;
        }

        print "\nChallenge 120, Task #2: Clock Angle (Perl)\n\n";
    }

    #--------------------------------------------------------------------------
    END
    #--------------------------------------------------------------------------
    {
        if ($^O =~ /MSWin/i)            # Restore the original active code page
        {
            my (undef, $stderr, $exit) = capture { system 'chcp', $code_page };

            warn $stderr if $stderr || $exit;
        }
    }
}

###############################################################################
