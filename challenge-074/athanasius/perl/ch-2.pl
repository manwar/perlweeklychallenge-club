#!perl

################################################################################
=comment

Perl Weekly Challenge 074
=========================

Task #2
-------
*FNR Character*

Submitted by: Mohammad S Anwar

You are given a string _$S_.

Write a script to print the series of first non-repeating character (left ->
right) for the given string. Print _#_ if none found.

Example 1

Input: $S = 'ababc'
Output: 'abb#c'

Pass 1: "a", the FNR character is 'a'
Pass 2: "ab", the FNR character is 'b'
Pass 3: "aba", the FNR character is 'b'
Pass 4: "abab", no FNR found, hence '#'
Pass 5: "ababc" the FNR character is 'c'

Example 2

Input: $S = 'xyzzyx'
Output: 'xyzyx#'

Pass 1: "x", the FNR character is "x"
Pass 2: "xy", the FNR character is "y"
Pass 3: "xyz", the FNR character is "z"
Pass 4: "xyzz", the FNR character is "y"
Pass 5: "xyzzy", the FNR character is "x"
Pass 6: "xyzzyx", no FNR found, hence '#'

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;        # Exports const()

const my $USAGE =>
"Usage:
  perl $0 <S>

    <S>    A non-empty string\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 074, Task #2: FNR Character (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    scalar @ARGV == 1 or die $USAGE;

    my $S     = $ARGV[0];
    my @chars = split //, $S;
    my $FNR   = '';
    my %count;

    for my $i (0 .. $#chars)
    {
        my $fnr = '#';

        if (++$count{ my $chr = $chars[$i] } == 1)
        {
            $fnr = $chr;
        }
        else
        {
            INNER: for my $j (reverse 0 .. $i - 1)
            {
                if ($count{ $chr = $chars[$j] } == 1)
                {
                    $fnr = $chr;
                    last INNER;
                }
            }
        }

        $FNR .= $fnr;
    }

    print "Input: \$S = '$S'\nOutput:     '$FNR'\n";
}

################################################################################
