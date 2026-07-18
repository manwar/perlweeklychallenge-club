#!perl

################################################################################
=comment

Perl Weekly Challenge 382
=========================

TASK #1
-------
*Hamiltonian Cycle*

Submitted by: Peter Campbell Smith

You are given a target number.

Write a script to arrange all the whole numbers from 1 up to the given target
number into a circle so that every pair of side-by-side numbers adds up to a
perfect square. Please make sure, the last number and the first must also add up
to a square.

Example 1

  Input: $n = 32
  Output:  1, 8, 28, 21,  4, 32, 17, 19, 30, 6,  3, 13, 12, 24, 25, 11, 5, 31,
          18, 7, 29, 20, 16,  9, 27, 22, 14, 2, 23, 26, 10, 15

  1  + 8  = 9
  8  + 28 = 36
  28 + 21 = 49
  21 + 4  = 25
  4  + 32 = 36
  32 + 17 = 49
  17 + 19 = 36
  19 + 30 = 49

  so on, all the way through the sequence.

Example 2

  Input: $n = 15
  Output: ()

  No valid circular list of numbers exists.

Example 3

  Input: $n = 34
  Output:  1, 8, 28, 21,  4, 32, 17, 19,  6, 30, 34, 15, 10, 26, 23, 2, 14, 22,
          27, 9, 16, 33, 31, 18,  7, 29, 20,  5, 11, 25, 24, 12, 13, 3

[2026-07-13 11:45]: Output was incorrect, corrected by E. Choroba.

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
2. A single, positive integer greater than 1 is entered on the command-line.

Algorithm
---------
Backtracking, implemented via recursion.

The cycle begins with the number 1. A depth-first search of the solution space
is made by examining, recursively, each possible successor to the last entry in
the cycle. At each stage, possible successors are considered in increasing
numerical order (smallest to greatest). The search ends when either the first solution has been found, or all possible solutions have been exhausted.

For testing, the output in Example 3 has been replaced by the cycle found by the
above algorithm.

Timings (rounded to whole seconds)
-------
n:  32 33 34 35 36 37 38 39 40 41 42 43 44  45  46  47
s:  <1  1 <1 <1  1  7 18 20  9 18  5 17 47 163 317 818

Reference
---------
[1] OEIS Foundation Inc. (2026), Entry A071984 in The On-Line Encyclopedia of
    Integer Sequences, https://oeis.org/A071984

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use boolean;
use warnings;
use Const::Fast;
use List::Util     qw( first );
use Regexp::Common qw( number );
use Test::More;

use constant TIMER  => true;
use constant ASSERT => false;

const my $MIN_N => 32;                     # See [1]: COMMENTS (Bert Dobbelaere)
const my $USAGE => <<END;
Usage:
  perl $0 <n>
  perl $0

    <n>    The target number, an integer > 1
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 382, Task #1: Hamiltonian Cycle (Perl)\n\n";
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
        use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

        my $t =  [gettimeofday]                      if TIMER;
        my $n =  $ARGV[0];
           $n =~ / ^ $RE{num}{int} $ /x && $n > 1
                 or error( qq["$n" is not a valid value for \$n] );

        print "Input:  \$n = $n\n";

        my $cycle = find_cycle( $n );

        printf "Output: (%s)\n", join ', ', @$cycle;

        printf "\n%.1f seconds\n", tv_interval( $t ) if TIMER;
    }
    else
    {
        error( "Expected 1 or 0 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_cycle
#-------------------------------------------------------------------------------
{
    my ($n) =  @_;
        $n  =~ / ^ $RE{num}{int} $ /x && $n > 1
               or die qq["$n" is not a valid value for \$n];
    my  @cycle;

    if ($n >= $MIN_N)
    {
        my %domain = map { $_ => true } 2 .. $n;
        push @cycle, 1;

        if (grow_cycle( $n, \@cycle, \%domain ))
        {
            is_a_cycle( $n, \@cycle ) or die 'Logic error' if ASSERT;
        }
        else
        {
            pop @cycle;
        }
    }

    return \@cycle;
}

#-------------------------------------------------------------------------------
sub grow_cycle                                            # Recursive subroutine
#-------------------------------------------------------------------------------
{
    my ($n, $cycle, $domain) = @_;

    return is_a_cycle( $n, $cycle ) unless first { $_ } values %$domain;

    my $partners = find_partners( $n, $cycle );

    if (scalar @$partners > 0)
    {
        for my $partner (@$partners)
        {
            $domain->{ $partner } = false;
            push @$cycle, $partner;

            return true if grow_cycle( $n, $cycle, $domain );

            pop @$cycle;
            $domain->{ $partner } = true;
        }
    }

    return false;
}

#-------------------------------------------------------------------------------
sub find_partners
#-------------------------------------------------------------------------------
{
    my    ($new_n, $cycle) = @_;
    state ($n, @squares);

    if (!defined $n || $n != $new_n)
    {
        $n       = $new_n;
        @squares = init_squares( $n );
    }

    my @partners;
    my $num = $cycle->[ -1 ];

    L_OUTER:
    for my $square (@squares)
    {
        if ($square > $num)
        {
            my $candidate = $square - $num;

            if ($n >= $candidate)
            {
                for my $term (@$cycle)
                {
                    next L_OUTER if $candidate == $term;
                }

                push @partners, $candidate;
            }
        }
    }

    return \@partners;
}

#-------------------------------------------------------------------------------
sub init_squares
#-------------------------------------------------------------------------------
{
    my ($n)     =  @_;
    my  $max_sq = (2 * $n) - 1;
    my  @squares;

    for (my $i = 2; true; ++$i)
    {
        my  $square = $i * $i;

        if ($square > $max_sq)
        {
            last;
        }
        else
        {
            push @squares, $square;
        }
    }

    return @squares;
}

#-------------------------------------------------------------------------------
sub is_a_cycle
#-------------------------------------------------------------------------------
{
    my ($n, $cycle) = @_;
    my  %domain     = map { $_ => false } (1 .. $n);

    for my $i (0 .. $#$cycle)
    {
        my $elem = $cycle->[ $i ];

        return false if !exists $domain{ $elem } || $domain{ $elem };

        my $j    = ($i == $#$cycle) ? 0 : $i + 1;
        my $sum  =  $elem + $cycle->[ $j ];
        my $root =  int( sqrt( $sum ) + 0.5 );

        return false unless $root * $root == $sum;

        $domain{ $elem } = true;
    }

    $_ || return false for values %domain;

    return true;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        while ($line =~ / \\ $ /x)
        {
            chomp $line;
            $line =~ s/ \s* \\ $ / /gx;
            $line .= <DATA>;
        }

        my  ($test_name, $n, $exp_str) = split / \| /x, $line;

        for ($test_name, $n, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $cycle    = find_cycle( $n );
        my @expected = split / \s+ /x, $exp_str;

        is_deeply $cycle, \@expected, $test_name;
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
Example 1|32| 1  8 28 21 4 32 17 19 30 6  3 13 12 24 25 11  5 31 18 7 29 20 16 \
              9 27 22 14 2 23 26 10 15
Example 2|15|
Example 3|34| 1  3 13 12 4 32 17 8 28 21 15 34 30 19  6 10 26 23 2 14 22 27  9 \
             16 33 31 18 7 29 20 5 11 25 24
