#!perl

###############################################################################
=comment

Perl Weekly Challenge 176
=========================

TASK #2
-------
*Reversible Numbers*

Submitted by: Mohammad S Anwar

Write a script to find out all Reversible Numbers below 100.


    A number is said to be a reversible if sum of the number and its reverse
    had only odd digits.


For example,

  36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
  17 is not reversible as 17 + 71 = 88, none of the digits are odd.

Output

  10, 12, 14, 16, 18, 21, 23, 25, 27,
  30, 32, 34, 36, 41, 43, 45, 50, 52,
  54, 61, 63, 70, 72, 81, 90

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Algorithm
---------
Each integer n in the range 0 to 99 is tested to determine whether it is re-
versible: a sum is calculated by adding n to its reverse, then each digit of
the sum is tested for divisibility by 2; if it is even, the test fails immedi-
ately; otherwise, the test proceeds until all digits have been tested.

Note: Perl's built-in reverse() function must be called in scalar context;
otherwise, it will treat a single argument as a single-element list and reverse
the elements in the list -- producing no change.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

const my $LIMIT => 100;
const my $USAGE => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 176, Task #2: Reversible Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @reversible;

    for my $n (0 .. $LIMIT - 1)
    {
        push @reversible, $n if is_reversible( $n );
    }

    printf "The reversible numbers below %d:\n%s\n", $LIMIT,
            join ', ', @reversible;
}

#------------------------------------------------------------------------------
sub is_reversible
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  $sum    = $n + scalar reverse $n;
    my  @digits = split //, $sum;

    for my $digit (@digits)
    {
        return 0 if $digit % 2 == 0;
    }

    return 1;
}

###############################################################################
