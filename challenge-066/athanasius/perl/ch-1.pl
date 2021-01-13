#!perl

################################################################################
=comment

Perl Weekly Challenge 066
=========================

Task #1
-------
*Divide Integers*

*Submitted by:* Mohammad S Anwar

You are given two integers $M and $N.

Write a script to divide the given two integers i.e. $M / $N without using
multiplication, division and mod operator and return the floor of the result of
the division.

*Example 1:*

 Input: $M = 5, $N = 2
 Output: 2

*Example 2:*

 Input: $M = -5, $N = 2
 Output: -3

*Example 3:*

 Input: $M = -5, $N = -2
 Output: 2

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use Modern::Perl   qw( 2018 );
use Const::Fast;
use POSIX          qw( ceil floor );
use Regexp::Common qw( number );

const my $USAGE => <<~EOS;
          Usage:
            perl $0 <M> <N>

              <M>    Dividend (integer)
              <N>    Divisor (non-zero integer)
          EOS

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    say "Challenge 066, Task #1: Divide Integers (Perl)\n";

    die $USAGE unless @ARGV == 2 && $ARGV[0] =~ / ^ $RE{num}{int} $ /x &&
                                    $ARGV[1] =~ / ^ $RE{num}{int} $ /x &&
                                    $ARGV[1] != 0;
    my ($M, $N)   = @ARGV;
    my  $quotient = 0;

    if ($M != 0)
    {
        my $ratio = exp( log(abs $M) - log(abs $N) );

        $quotient = (($M > 0) && ($N > 0) ||
                     ($M < 0) && ($N < 0)) ? floor($ratio) : -ceil($ratio);
    }

    say "$M \\ $N = $quotient";
}

################################################################################
