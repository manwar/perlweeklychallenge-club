use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note on Output
--------------
Should fractions of a degree be output as decimals or as minutes and seconds?
The issue is simplified by the observation that the smallest fraction is half a
degree. (See below: ma-deg = (hours * 30) + (mins / 60) * 30
                           = (hours * 30) + (mins / 2)
and since hours and mins are both positive integers, ma-deg ends in 0.5° when
the value of mins is odd.) Therefore, whole-number solutions are output as
degrees only; solutions ending in 0.5° are output as both --.5° and --° 30' 0".

Algorithm
---------
Extract hour and mins from T using a regular expression

Let "the axis" be the vertical line passing through points 12 and 6 on the
    clockface

Let ha-deg be the angle, in degrees, between the axis and the hour hand of the
    clock, moving clockwise from the axis to the hour hand
Calculation:
    ha-deg = mins * 60°

Let ma-deg be the angle, in degrees, between the axis and the minute hand of
    the clock, moving clockwise from the axis to the minute hand
Calculation:
    ma-deg = (hours * 30°) + (mins / 60) * 30°

Let hm-deg be the smaller of the two angles, in degrees, between the hour and
    minutes hands of the clock at the specified time
Calculation:
    1. hm-deg = |ha-deg - ma-deg|
    2. IF hm-deg > 180° THEN hm-deg = 360° - hm-deg

Interface
---------
This script was developed and tested under Windows 8.1 (64-bit), with output to
a Command Prompt screen. For proper display of the degree symbol (°), the Win-
dows active code page is set to 65001 (Unicode, UTF-8). This is implemented in
a BEGIN block. The original active code page is restored on script completion
in an END block.

Note that the code page 65001 implementation for the Command Prompt is buggy.
The addition of carriage return characters to the final output statements is a
kludge to work around a bug which duplicates the final two characters of
output.

=end comment
#==============================================================================

my Int  constant DEGS-PER-CIRCLE  = 360;
my Int  constant HRS-PER-HALF-DAY =  12;
my Int  constant MINUTES-PER-HOUR =  60;
my Int  constant DEGS-PER-HOUR    = (DEGS-PER-CIRCLE / HRS-PER-HALF-DAY).Int;
my Int  constant DEGS-PER-MINUTE  = (DEGS-PER-CIRCLE / MINUTES-PER-HOUR).Int;
my Int  constant CODE-PAGE        = 65001;
my Real constant EPSILON          = 1e-12;

#==============================================================================
sub MAIN
(
    Str:D $T where / ^ \d\d \: \d\d $ /     #= A time in 12-hour "hh:mm" format
)
#==============================================================================
{
    my UInt ($hour, $mins) = parse-time( $T );

    "Input:  \$T = %02d:%02d\n".printf: $hour, $mins;

    my UInt $ma-deg =  DEGS-PER-MINUTE *  $mins;
    my Real $ha-deg =  DEGS-PER-HOUR   * ($hour + $mins / MINUTES-PER-HOUR);
    my Real $hm-deg = ($ha-deg - $ma-deg).abs;
            $hm-deg =  DEGS-PER-CIRCLE - $hm-deg
                           if $hm-deg > (DEGS-PER-CIRCLE / 2);
    my Real $diff   =  $hm-deg - $hm-deg.floor;

    if     $diff        < EPSILON        # There is no fractional part
    {
        "Output: $hm-deg°\n\r\r".print;
    }
    elsif ($diff - 0.5) < EPSILON        # Fractional part is 0.5° (i.e., 30')
    {
        qq[Output: %.1f° (= %d° 30' 0")\n\r\r].printf: $hm-deg, $hm-deg;
    }
    else
    {
        die "\$diff = $diff";             # Impossible case
    }
}

#------------------------------------------------------------------------------
sub parse-time( Str:D $T --> List:D[ UInt:D, UInt:D ] )
#------------------------------------------------------------------------------
{
    my UInt ($hour, $mins) = $T.split( ':' ).map: { .Int };

    0 <  $hour <= 12
        or error( qq[Hour "%02d" is outside range 1 to 12].sprintf: $hour );

    0 <= $mins <  60
        or error( qq[Minutes "$mins" is outside range 0 to 59] );

    return [ $hour, $mins ];
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

#==============================================================================
# Initialize and finalize
#==============================================================================
{
    my Int $code-page;

    #--------------------------------------------------------------------------
    BEGIN
    #--------------------------------------------------------------------------
    {
        # Facilitate correct display of the degree symbol (°) in the Windows
        # Command Prompt window

        if VM.osname ~~ m:i/ MSWin /
        {
            my Proc $proc   = run 'chcp', :out, :err;
            my Str  $error  = $proc.err.slurp:  :close;
            my Str  $stdout = $proc.out.slurp:  :close;

            note $error if $error;

            $stdout ~~ / ^ Active \s code \s page \: \s (\d+) \s $ /;
            $code-page = $0.Int;

            $proc  = run 'chcp', CODE-PAGE, :out, :err;
            $error = $proc.err.slurp: :close;

            note $error if $error;
        }

        "\nChallenge 120, Task #2: Clock Angle (Raku)\n".put;
    }

    #--------------------------------------------------------------------------
    END
    #--------------------------------------------------------------------------
    {
        if VM.osname ~~ m:i/ MSWin /    # Restore the original active code page
        {
            my Proc $proc  = run 'chcp', $code-page, :out, :err;
            my Str  $error = $proc.err.slurp: :close;

            note $error if $error;
        }
    }
}

##############################################################################
