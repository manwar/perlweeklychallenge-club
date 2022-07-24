#!perl

###############################################################################
=comment

Perl Weekly Challenge 174
=========================

TASK #1
-------
*Disarium Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 19 Disarium Numbers.


        A disarium number is an integer where the sum of each digit raised to
        the power of its position in the number, is equal to the number.


For example,

  518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 =>
  518

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes
-----
Discovery of disarium numbers [1]  proceeds by testing all integers, beginning
with 1, against the given criteria. The time taken to find the first 18 dis-
arium numbers is negligible (~0.01 seconds); but discovery of the 19th disarium
number takes about 17 seconds. The following strategies have been tried in
order to make subroutine is_disarium() more efficient:

    - The subroutine returns a false value as soon as the sum exceeds $n.
    - Higher powers are tested before lower powers: this results in a saving of
      about 1 second.
    - Pre-computation of powers, using a look-up table to replace the exponen-
      tiation operator, was tried, but did not produce any appreciable speed-
      up.

Reference
---------
[1] "A032799  Numbers n such that n equals the sum of its digits raised to the
     consecutive powers (1,2,3,...).", OEIS, https://oeis.org/A032799

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

use constant TIMER => 0;

const my $TARGET => 19;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 174, Task #1: Disarium Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

    my $t0   = [gettimeofday] if TIMER;
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    print "The first $TARGET disarium numbers:\n0";

    my $count = 1;

    for (my $n = 1; $count < $TARGET; ++$n)
    {
        if (is_disarium( $n ))
        {
            print ", $n";
            ++$count;
        }
    }

    print  "\n";
    printf "\n%.2f seconds\n", tv_interval( $t0 ) if TIMER;
}

#------------------------------------------------------------------------------
sub is_disarium
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @digits = split //, $n;
    my  $sum    = 0;

    for my $i (reverse 0 .. $#digits)          # reverse() here saves ~1 second
    {
        $sum += $digits[ $i ] ** ($i + 1);

        return 0 if $sum > $n;
    }

    return $sum == $n;
}

###############################################################################
