#!perl

################################################################################
=comment

Perl Weekly Challenge 277
=========================

TASK #2
-------
*Strong Pair*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the count of all strong pairs in the given array.

    A pair of integers x and y is called strong pair if it satisfies:
    0 < |x - y| < min(x, y).

Example 1

  Input: @ints = (1, 2, 3, 4, 5)
  Output: 4

  Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)

Example 2

  Input: @ints = (5, 7, 1, 7)
  Output: 1

  Strong Pairs: (5, 7)

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
2. If an explanation of the output is required, the flag "--verbose" is entered
   on the command-line.
3. The input integers are entered as a non-empty list at the end of the command-
   line.
4. If any input integer is negative, the first such must be preceded by "--" to
   indicate that it is not a command-line flag.

Assumption
----------
Within a strong pair (x, y), the order of x and y is not significant. So (x, y)
is the same strong pair as (y, x). For convenience, strong pairs are always
given as (x, y) where x < y (see Analysis below).

Analysis
--------
Requirements (given): (a) 0 < |x - y|
                      (b) 0 < min(x, y)         (by transitivity)
                      (c) |x - y| < min(x, y)

1. Let d = |x - y|. If x = y, then d = 0; but from (a) we know that 0 < d, so it
   follows that x ≠ y.
2. For convenience, let each strong pair (x, y) be ordered such that x < y.
   Then min(x, y) = x.
3. From (2) together with (b) it follows that x > 0; and from (1) we know that
   d > 0. But if x = 1, (c) is impossible; therefore, x > 1.
4. From (c) we have y - x < x. Adding x to both sides yields y < 2x.

Summary. For any strong pair (x, y) ordered so that x < y, it is required that:

                      (d) 1 < x < y < 2x

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( uniqint );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [--verbose] [<ints> ...]
  perl $0

    --verbose       Explain the output? [default: False]
    [<ints> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 277, Task #2: Strong Pair (Perl)\n\n";
}

#-------------------------------------------------------------------------------
package StrongPair
#-------------------------------------------------------------------------------
{
    use Moo;
    use Types::Standard qw( Int );
    use namespace::clean;

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    has x =>
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (
        is  => 'ro',
        isa =>  Int
    );

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    has y =>
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    (
        is  => 'ro',
        isa =>  Int
    );

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub BUILD                                                     # Sanity check
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($self) = @_;
        my  $x     = $self->{ x };
        my  $y     = $self->{ y };

        $x < $y && 0 < ($y - $x) < $x or die 'Invalid StrongPair';
    }

    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    sub fmt
    #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    {
        my ($self) = @_;
        my  $x     = $self->{ x };
        my  $y     = $self->{ y };

        return "($x, $y)";
    }
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

        my $pairs = find_strong_pairs( $ints );
        my $count = scalar @$pairs;

        print "Output: $count\n";

        if ($verbose && $count > 0)
        {
            printf "\nStrong pair%s: %s\n",
                    $count == 1 ? '' : 's', join ', ', map { $_->fmt } @$pairs;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_strong_pairs
#-------------------------------------------------------------------------------
{
    my ($ints_arg) = @_;
    my  @ints      = sort { $a <=> $b } uniqint grep { $_ > 1 } @$ints_arg;
    my  @pairs;

    for my $i (0 .. $#ints - 1)
    {
        for my $j ($i + 1 .. $#ints)
        {
            my $x = $ints[ $i ];
            my $y = $ints[ $j ];

            if ($y < 2 * $x)            # See requirement (d) in Analysis, above
            {
                push @pairs, StrongPair->new( x => $x, y => $y );
            }
            else
            {
                last;
            }
        }
    }

    return \@pairs;
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

        my  ($test_name, $ints_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split /    \s+ /x, $ints_str;
        my $pairs    = find_strong_pairs( \@ints );
        my @exp_strs = split / \; \s* /x, $exp_str;
        my @expected;

        for my $str (@exp_strs)
        {
            my ($x, $y) = split / \s+ /x, $str;

            push @expected, StrongPair->new( x => $x, y => $y );
        }

        is_deeply $pairs, \@expected, $test_name; 
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
Example 1|1 2 3 4 5|2 3; 3 4; 3 5; 4 5
Example 2|5 7 1 7  |5 7
