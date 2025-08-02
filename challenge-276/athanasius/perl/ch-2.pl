#!perl

################################################################################
=comment

Perl Weekly Challenge 276
=========================

TASK #2
-------
*Maximum Frequency*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers, @ints.

Write a script to return the total number of elements in the given array which
have the highest frequency.

Example 1

  Input: @ints = (1, 2, 2, 4, 1, 5)
  Output: 4

  The maximum frequency is 2.
  The elements 1 and 2 has the maximum frequency.

Example 2

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 5

  The maximum frequency is 1.
  The elements 1, 2, 3, 4 and 5 has the maximum frequency.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
"Positive integers" are greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input integers are entered as a non-empty list at the end of the command-
   line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( max );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--verbose] [<ints> ...]
  perl $0

    --verbose       Explain the output? [default: False]
    [<ints> ...]    A list of positive integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 276, Task #2: Maximum Frequency (Perl)\n\n";
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
        my ($verbose, $ints) = parse_command_line();

        printf "Input:  \@ints = (%s)\n", join ', ', @$ints;

        my $max = max_freq( $ints );

        printf "Output: %d\n", $max->{ count };

        if ($verbose)
        {
            printf "\nMaximum frequency: %d\n", $max->{ freq };

            printf "Element%s with the maximum frequency: %s\n",
                    scalar     $max->{ elems }->@* == 1 ? '' : 's',
                    join ', ', $max->{ elems }->@*;
        }
    }
}

#-------------------------------------------------------------------------------
sub max_freq
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %freq;
      ++$freq{ $_ } for @$ints;

    my  %max = (freq => max( values %freq ), count => 0);
    my  %elem;

    for (@$ints)
    {
        if ($freq{ $_ } == $max{ freq })
        {
            ++$elem{ $_ };
            ++$max{ count };
        }
    }

    $max{ elems } = [ sort { $a <=> $b } keys %elem ];

    return \%max;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my $verbose = 0;

    GetOptions
    (
        verbose => \$verbose
    )                          or error( 'Invalid command-line argument' );

    my @ints = @ARGV;

    scalar @ints > 0           or error( 'Missing command-line input' );

    for (@ints)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        $_ > 0                 or error( qq["$_" is not positive] );
    }

    return ($verbose, \@ints);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints, $exp_max_freq, $elems, $exp_count) =
             split / \| /x, $line;

        for ($test_name, $ints, $exp_max_freq, $elems, $exp_count)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints      = split / \s+ /x, $ints;
        my @exp_elems = split / \s+ /x, $elems;
        my $max       = max_freq( \@ints );

        is        $max->{ freq  },  $exp_max_freq, $test_name;
        is_deeply $max->{ elems }, \@exp_elems,    $test_name;
        is        $max->{ count },  $exp_count,    $test_name;
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
Example 1  |1 2 2 4 1 5|2|1 2      |4
Example 2  |1 2 3 4 5  |1|1 2 3 4 5|5
Single elem|7 3 7 5 7 9|3|7        |3
