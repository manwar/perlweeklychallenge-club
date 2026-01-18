#!perl

################################################################################
=comment

Perl Weekly Challenge 356
=========================

TASK #1
-------
*Kolakoski Sequence*

Submitted by: Mohammad Sajid Anwar

You are given an integer, $int > 3.

Write a script to generate the Kolakoski Sequence of given length $int and
return the count of 1 in the generated sequence. Please follow the
[ https://en.wikipedia.org/wiki/Kolakoski_sequence |wikipedia page] for more
informations.

Example 1

  Input: $int = 4
  Output: 2

  (1)(22)(11)(2) => 1221

Example 2

  Input: $int = 5
  Output: 3

  (1)(22)(11)(2)(1) => 12211

Example 3

  Input: $int = 6
  Output: 3

  (1)(22)(11)(2)(1)(22) => 122112

Example 4

  Input: $int = 7
  Output: 4

  (1)(22)(11)(2)(1)(22)(1) => 1221121

Example 5

  Input: $int = 8
  Output: 4

  (1)(22)(11)(2)(1)(22)(1)(22) => 12211212

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. An integer greater than 3 is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my @INIT_SEQ => (1, 2, 2);
const my $USAGE    => <<END;
Usage:
  perl $0 <int>
  perl $0

    <int>    An integer greater than 3
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 356, Task #1: Kolakoski Sequence (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 1)
    {
        my $int = $ARGV[0];

        $int =~ /^$RE{num}{int}$/ or error( qq["$int" is not a valid integer] );
        $int >= scalar @INIT_SEQ  or error( "$int is too small" );

        print "Input:  \$int = $int\n";

        my $ones = count_ones( $int );

        print "Output: $ones\n";
    }
    else
    {
        error( "Expected 1 or 0 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub count_ones
#-------------------------------------------------------------------------------
{
    my ($int) = @_;
        $int >= scalar @INIT_SEQ or die "$int is too small";
    my  @seq  = @INIT_SEQ;
    my  $i    = $#seq;
    my  $sym  = $seq[-1] == 1 ? 2 : 1;

    while ($int > scalar @seq)
    {
        push @seq, ($sym) x $seq[$i++];

        $sym = ($sym == 1) ? 2 : 1;
    }

    pop @seq while scalar @seq > $int;

    return scalar grep { $_ == 1 } @seq;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int, $expected) = split / \| /x, $line;

        for ($test_name, $int, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $ones = count_ones( $int );

        is $ones, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|  4| 2
Example 2|  5| 3
Example 3|  6| 3
Example 4|  7| 4
Example 5|  8| 4
OEIS     |108|53
