use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 179
=========================

TASK #2
-------
*Unicode Sparkline*

Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n.

Write a script to print sparkline in Unicode for the given list of numbers.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------
1. Strictly speaking, sparklines are line charts [2]. However, the Rosetta Code
   task "Sparkline in unicode" [3] specifies output in the form of bar charts
   drawn using the 8 Unicode characters U+2581 through U+2588. Given that the
   Task description calls for a "sparkline in Unicode", the Rosetta Code speci-
   fication is adopted here.

2. In a normal bar chart, the y axis should start at zero; otherwise, it is a
   truncated (or torn) graph, which "can create the impression of important
   change where there is relatively little change" [1]. A sparkline, on the
   other hand, "presents the general shape of the variation...in some measure-
   ment" and so should normally not start at zero. The elements in a sparkline
   range in value between the minimum and maximum data points only.

Note
----
Script output tested under Windows 8.1 using Rakudo v2022.04 (implementing Raku
v6.d) running under Cygwin 2.8.2-1.

References
----------
[1] "Misleading graph", Wikipedia,
     https://en.wikipedia.org/wiki/Misleading_graph
[2] "Sparkline", Wikipedia, https://en.wikipedia.org/wiki/Sparkline
[3] "Sparkline in unicode", Rosetta Code,
     https://rosettacode.org/wiki/Sparkline_in_unicode

=end comment
#==============================================================================

my constant @CHARS = < ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ >;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 179, Task #2: Unicode Sparkline (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@n where { .elems > 0 }                    #= One or more positive numbers
)
#==============================================================================
{
    my Real @nums  = parse-command-line( @n );

    "Input:  %s\n\n".printf: @nums.join: ', ';

    my Str  @sparkline;
    my Real $min   = @nums.min;
    my Real $max   = @nums.max;
    my Real $range = $max - $min;

    if $range
    {
        for @nums -> Real $n
        {
            my UInt $idx = 7;

            for 1 .. 7 -> UInt $i
            {
                if ($n - $min) < ($i * $range / 8)
                {
                    $idx = $i - 1;
                    last;
                }
            }

            @sparkline.push: @CHARS[ $idx ];
        }
    }
    else
    {
        @sparkline = @CHARS[ 0 ] xx @nums.elems;
    }

    "Output: %s\n".printf: @sparkline.join;
}

#------------------------------------------------------------------------------
sub parse-command-line( *@n --> Array:D[Real:D] )
#------------------------------------------------------------------------------
{
    my Real @nums;

    for @n
    {
        my Str $n = S/ (\,) $ //;    # Remove trailing comma separator (if any)

        $n.Real ~~ Failure and error( qq["$n" is not a valid real number] );
        $n.Real >= 0       or  error( qq["$n" is not a positive number]   );

        @nums.push: $n.Real;
    }

    return @nums;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
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
