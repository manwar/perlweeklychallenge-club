#!perl

###############################################################################
=comment

Perl Weekly Challenge 179
=========================

TASK #2
-------
*Unicode Sparkline*

Submitted by: Mohammad S Anwar

You are given a list of positive numbers, @n.

Write a script to print sparkline in Unicode for the given list of numbers.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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
Script output tested under Windows 8.1 using Perl v5.22.4 running under Cygwin
2.8.2-1.

References
----------
[1] "Misleading graph", Wikipedia,
     https://en.wikipedia.org/wiki/Misleading_graph
[2] "Sparkline", Wikipedia, https://en.wikipedia.org/wiki/Sparkline
[3] "Sparkline in unicode", Rosetta Code,
     https://rosettacode.org/wiki/Sparkline_in_unicode

=cut
#==============================================================================

use strict;
use warnings;
use utf8;
use Const::Fast;
use List::Util     qw( max min );
use Regexp::Common qw( number );

const my @CHARS => qw( ▁ ▂ ▃ ▄ ▅ ▆ ▇ █ );
const my $USAGE =>
"Usage:
  perl $0 [<n> ...]

    [<n> ...]    One or more positive numbers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    binmode(STDOUT, ':utf8');
    print "\nChallenge 179, Task #2: Unicode Sparkline (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @n = parse_command_line();

    printf "Input:  %s\n\n", join ', ', @n;

    my @sparkline;
    my $min   = min @n;
    my $max   = max @n;
    my $range = $max - $min;

    if ($range == 0)
    {
        @sparkline = ($CHARS[ 0 ]) x scalar( @n );
    }
    else
    {
        for my $n (@n)
        {
            my $idx = 7;

            for my $i (1 .. 7)
            {
                if (($n - $min) < ($i * $range / 8))
                {
                    $idx = $i - 1;
                    last;
                }
            }

            push @sparkline, $CHARS[ $idx ];
        }
    }

    printf "Output: %s\n",   join '', @sparkline;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 0 and error( 'No command line arguments found' );

    my @n = @ARGV;

    for my $n (@n)
    {
        $n =~ s/ (,) $ //x;          # Remove trailing comma separator (if any)

        $n =~ / ^ $RE{num}{real} $ /x
                  or  error( qq["$n" is not a valid real number] );
        $n >= 0   or  error( qq["$n" is not a positive number]   );
    }

    return @n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
