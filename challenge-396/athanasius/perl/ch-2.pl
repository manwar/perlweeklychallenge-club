#!perl

################################################################################
=comment

Perl Weekly Challenge 396
=========================

TASK #2
-------
*Trionic Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integer.

Write a script to return true if the given array is Trionic otherwise return
false.

    An array is trionic if there exist indices 0 < p < q < n − 1 such that
    arr[0…p] is strictly increasing, arr[p…q] is strictly decreasing, and
    arr[q…n − 1] is strictly increasing.

Example 1

  Input: @arr = (1, 3, 5, 4, 2, 6, 8)
  Output: true

  Choose p = 2 and q = 4
  $arr[0..2] = (1, 3, 5) (strictly increasing)
  $arr[2..4] = (5, 4, 2) (strictly decreasing)
  $arr[4..6] = (2, 6, 8) (strictly increasing)

  Valid indices: 0 < p (2) < q (4) < n-1 (6).

Example 2

  Input: @arr = (1, 4, 4, 2, 1, 3, 5)
  Output: false

  The first segment (1, 4, 4) contains duplicate adjacent values, so it is not
  strictly increasing.
  No valid p and q exist to satisfy all three strictly monotonic conditions.

Example 3

  Input: @arr = (2, 10, 3, 1, 9)
  Output: true

  Choose p = 1 and q = 3.
  $arr[0..1] = (2, 10)    (strictly increasing)
  $arr[1..3] = (10, 3, 1) (strictly decreasing)
  $arr[3..4] = (1, 9)     (strictly increasing)

Example 4

  Input: @arr = (1, 2, 3, 4, 3, 2, 1)
  Output: false

  This is a standard mountain array (strictly increasing, then strictly
  decreasing).
  There is no second valley (q) that transitions back into a strictly increasing
  third segment before reaching the end of the array.

Example 5

  Input: @arr = (1, 3, 6, 4, 2, 7, 8, 4)
  Output: false

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
2. A non-empty list of integers is entered on the command-line.
3. If "-v" or "--verbose" is entered as a command-line flag (along with one or
   more integers), then, if the given list is trionic, the values of p and q
   (the indices of the peak and the valley) are appended to the standard output.
4. If any of the integers entered on the command-line is negative, the first
   such must be preceded by "--" to indicate that what follows does not contain
   command-line flags.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use boolean;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-v|--verbose] [<array> ...]
  perl $0

    [<array> ...]    Non-empty list of integers
    -v|--verbose     Output p and q?
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 396, Task #2: Trionic Array (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $verbose;

    GetOptions( verbose => \$verbose )
        or error( 'Invalid command-line option(s)' );

    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ARGV;

        printf "Input:  \@array = (%s)\n", join ', ', @ARGV;

        my ($p, $q);
        my  $trionic = is_trionic( \@ARGV, \$p, \$q );

        printf "Output: %s\n", $trionic ? 'true' : 'false';

        print  "\np (peak index) = $p and q (valley index) = $q\n"
            if $verbose && $trionic;
    }
}

#-------------------------------------------------------------------------------
sub is_trionic
#-------------------------------------------------------------------------------
{
    my ($array, $p, $q) = @_;
    my  $ascent_1 = true;
    my  $descent  = false;

    return false if scalar @$array < 4 || $array->[0] >= $array->[1];

    for my $i (1 .. $#$array - 1)
    {
        my $diff = $array->[$i] - $array->[$i + 1];

        return false if $diff == 0;

        if ($ascent_1)
        {
            if ($diff > 0)
            {
                $ascent_1 = false;
                $descent  = true;
                $$p       = $i;   # Created by l-value autovivification if undef
            }
        }
        elsif ($descent)
        {
            if ($diff < 0)
            {
                $descent  = false;
                $$q       = $i;   # Created by l-value autovivification if undef
            }
        }
        else  # Second ascent
        {
            return false if $diff > 0;
        }
    }

    return !$ascent_1 && !$descent;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    say 'Running the test suite';

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $array_str, $exp_trionic, $exp_p, $exp_q) =
             split / \| /x, $line;

        for ($test_name, $array_str, $exp_trionic, $exp_p, $exp_q)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my ($p, $q);
        my  @array   = split / \s+ /x, $array_str;
        my  $trionic = is_trionic( \@array, \$p, \$q );

        if ($trionic)
        {
            is 'true',  $exp_trionic, "$test_name: trionic";
            is  $p,     $exp_p,       "$test_name: p";
            is  $q,     $exp_q,       "$test_name: q";
        }
        else
        {
            is 'false', $exp_trionic, "$test_name: trionic";
        }
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
Example 1|1  3 5 4 2 6 8              |true |2|4
Example 2|1  4 4 2 1 3 5              |false| |
Example 3|2 10 3 1 9                  |true |1|3
Example 4|1  2 3 4 3 2 1              |false| |
Example 5|1  3 6 4 2 7 8 4            |false| |
Negatives|1  2 3 4 3 2 1 0 -1 -2 3 4 5|true |3|9
