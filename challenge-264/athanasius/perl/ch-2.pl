#!perl

################################################################################
=comment

Perl Weekly Challenge 264
=========================

TASK #2
-------
*Target Array*

Submitted by: Mohammad Sajid Anwar

You are given two arrays of integers, @source and @indices. The @indices can
only contains integers 0 <= i < size of @source.

Write a script to create target array by insert at index $indices[i] the value
$source[i].

Example 1

  Input: @source  = (0, 1, 2, 3, 4)
         @indices = (0, 1, 2, 2, 1)
  Output: (0, 4, 1, 3, 2)

  @source  @indices  @target
  0        0         (0)
  1        1         (0, 1)
  2        2         (0, 1, 2)
  3        2         (0, 1, 3, 2)
  4        1         (0, 4, 1, 3, 2)

Example 2

  Input: @source  = (1, 2, 3, 4, 0)
         @indices = (0, 1, 2, 3, 0)
  Output: (0, 1, 2, 3, 4)

  @source  @indices  @target
  1        0         (1)
  2        1         (1, 2)
  3        2         (1, 2, 3)
  4        3         (1, 2, 3, 4)
  0        0         (0, 1, 2, 3, 4)

Example 3

  Input: @source  = (1)
         @indices = (0)
  Output: (1)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The lists $source and $indices are entered as named-argument strings on the
   command-line.
 - Each is a list of integers separated by whitespace.
 - $indices contains unsigned integers (i, j, k, ...) such that each is less
   than or equal to its own index position in the list: i = 0, 0 <= j <= 1,
   0 <= k <= 2, etc.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--source=<Str>] [--indices=<Str>]
  perl $0

    --source=<Str>     A whitespace-separated list of integers
    --indices=<Str>    A whitespace-separated list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 264, Task #2: Target Array (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my ($source, $indices) = parse_command_line();

        printf "Input:  \@source  = (%s)\n", join ', ', @$source;
        printf "        \@indices = (%s)\n", join ', ', @$indices;

        my $target = construct_target( $source, $indices );

        printf "Output: \@target  = (%s)\n", join ', ', @$target;
    }
}

#-------------------------------------------------------------------------------
sub construct_target
#-------------------------------------------------------------------------------
{
    my ($source, $indices) = @_;
    my  @target;

    for my $i (0 .. $#$source)
    {
        splice @target, $indices->[ $i ], 0, $source->[ $i ];
    }

    return \@target;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($source_str, $indices_str);

    GetOptions
    (
        'source=s'   => \$source_str,
        'indices2=s' => \$indices_str

    )                 or error( 'Invalid command-line arguments' );

    $source_str       // error( 'Missing source' );
    $indices_str      // error( 'Missing indices' );
    scalar @ARGV == 0 or error( 'Extra command-line arguments' );

    my $source  = parse_source ( $source_str  );
    my $indices = parse_indices( $indices_str );

    scalar @$source == scalar @$indices
                      or error( 'The input lists are of different sizes' );

    return ($source, $indices);
}

#-------------------------------------------------------------------------------
sub parse_source
#-------------------------------------------------------------------------------
{
    my ($source_str) = @_;
    my  @source;

    for my $s (split / \s+ /x, $source_str)
    {
        $s =~ / ^ $RE{num}{int} $ /x
            or error( qq["$s" is not a valid integer] );

        push @source, $s;
    }

    return \@source;
}

#-------------------------------------------------------------------------------
sub parse_indices
#-------------------------------------------------------------------------------
{
    my ($indices_str) = @_;
    my  $count        = 0;
    my  @indices;

    for my $i (split / \s+ /x, $indices_str)
    {
        $i =~ / ^ $RE{num}{int} $ /x
                       or error( qq["$i" is not a valid integer] );
        $i >= 0        or error( qq["$i" is negative] );
        $i <= $count++ or error( qq[The index "$i" is too large] );

        push @indices, $i;
    }

    return \@indices;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $source_str, $indices_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $source_str, $indices_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @source   = split / \s+ /x, $source_str;
        my @indices  = split / \s+ /x, $indices_str;
        my @expected = split / \s+ /x, $expected_str;
        my $target   = construct_target( \@source, \@indices );

        is_deeply $target, \@expected, $test_name;
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
Example 1|0 1 2 3 4|0 1 2 2 1|0 4 1 3 2
Example 2|1 2 3 4 0|0 1 2 3 0|0 1 2 3 4
Example 3|1        |0        |1
