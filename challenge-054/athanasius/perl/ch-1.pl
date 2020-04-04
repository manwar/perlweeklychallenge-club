#!perl

################################################################################
=comment

Perl Weekly Challenge 054
=========================

Task #1
*kth Permutation Sequence*

Write a script to accept two integers *n (>=1)* and *k (>=1)*. It should print
the *kth permutation* of *n integers*. For more information, please follow the
[ https://en.wikipedia.org/wiki/Permutation#k-permutations_of_n |wiki page].

For example, *n=3* and *k=4*, the possible permutation sequences are listed
below:

  123
  132
  213
  231
  312
  321

The script should print the *4th* permutation sequence *231*.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Algorithm::Loops      qw( NextPermuteNum );
use Const::Fast;
use Scalar::Util::Numeric qw( isint );

const my $USAGE =>
  "USAGE: perl $0 <N> <K> - Find the Kth permutation of the sequence 1 .. N\n" .
  "                              where N and K are integers >= 1\n";

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
    print "Challenge 054, Task #1: kth Permutation Sequence (Perl)\n\n";

    scalar @ARGV == 2   or die "ERROR: Incorrect number of arguments\n$USAGE";

    my ($n, $k) = @ARGV;

    isint($n) && $n > 0 or die "ERROR: '$n' is not a valid value for N\n$USAGE";
    isint($k) && $k > 0 or die "ERROR: '$k' is not a valid value for K\n$USAGE";

    my  @list   =  1 .. $n;
    my  $sep    = ($n < 10) ? '' : ' ';

    NextPermuteNum( @list ) for 2 .. $k;

    printf "The %s permutation of %s is %s\n",
            ordinal($k), join($sep, 1 .. $n), join($sep, @list);
}

#-------------------------------------------------------------------------------
sub ordinal
#-------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  $suffix = 'th';
    my  $dig1   = int(($n % 100) / 10);

    unless ($dig1 == 1)
    {
        my $dig0 = $n % 10;
        $suffix  = $dig0 == 1 ? 'st' :
                   $dig0 == 2 ? 'nd' :
                   $dig0 == 3 ? 'rd' : 'th';
    }

    return $n . $suffix;
}

################################################################################
