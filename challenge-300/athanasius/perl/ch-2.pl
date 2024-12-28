#!perl

################################################################################
=comment

Perl Weekly Challenge 300
=========================

TASK #2
-------
*Nested Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints of length n containing permutation of
the numbers in the range [0, n - 1].

Write a script to build a set, set[i] = ints[i], ints[ints[i]],
ints[ints[ints[i]]], ..., subjected to the following rules:

  1. The first element in set[i] starts with the selection of elements ints[i].
  2. The next  element in set[i] should be ints[ints[i]], and then
     ints[ints[ints[i]]], and so on.
  3. We stop adding right before a duplicate element occurs in set[i].

Return the longest length of a set set[i].

Example 1

  Input: @ints = (5, 4, 0, 3, 1, 6, 2)
  Output: 4

  ints[0] = 5
  ints[1] = 4
  ints[2] = 0
  ints[3] = 3
  ints[4] = 1
  ints[5] = 6
  ints[6] = 2

  One of the longest sets set[k]:
  set[0] = {ints[0], ints[5], ints[6], ints[2]} = {5, 6, 2, 0}

Example 2

  Input: @ints = (0, 1, 2)
  Output: 1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The given integers are valid array indices, and therefore unsigned.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line. This
   list, of length n, must be a permutation of the numbers in the range 0 to
   n - 1.
3. If the constant $VERBOSE is set to a true value, the contents of the longest
   set are appended to the required output of longest set length.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use List::Util     qw( any max min );
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    List of n integers constituting a permutation of 0 .. n - 1
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 300, Task #2: Nested Array (Perl)\n\n";
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
        my $ints = verify_input();

        printf "Input:  \@ints = (%s)\n", join ', ', @$ints;

        my $longest_set = find_longest_set( $ints );

        printf "Output: %d\n", scalar @$longest_set;

        printf "\nFirst solution: \{%s\}\n", join ', ', @$longest_set
            if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub find_longest_set
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @longest_set;

    for my $i (0 .. $#$ints)
    {
        my @set = $ints->[ $i ];

        while (1)
        {
            my $next = $ints->[ $set[ -1 ] ];

            if (any { $_ == $next } @set)
            {
                @longest_set = @set if scalar @set > scalar @longest_set;
                last;
            }

            push @set, $next;
        }
    }

    return \@longest_set;
}

#-------------------------------------------------------------------------------
sub verify_input
#-------------------------------------------------------------------------------
{
    my @ints = @ARGV;

    for my $int (@ints)
    {
        $int =~ / ^ $RE{num}{int} $ /x
                             or error( qq["$int" is not a valid integer] );
        $int >= 0            or error( "$int is not positive" );
    }

    is_permutation( \@ints ) or error( 'Not a valid permutation' );

    return \@ints;
}

#-------------------------------------------------------------------------------
sub is_permutation
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    return 0 unless min( @$ints ) == 0;
    return 0 unless max( @$ints ) == $#$ints;

    my %count;

    for my $int (@$ints)
    {
        return 0 if ++$count{ $int } > 1;
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $set  = find_longest_set( \@ints );

        is scalar @$set, $expected, $test_name;
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
Example 1|5 4 0 3 1 6 2|4
Example 2|0 1 2        |1
