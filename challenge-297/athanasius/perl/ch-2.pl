#!perl

################################################################################
=comment

Perl Weekly Challenge 297
=========================

TASK #2
-------
*Semi-Ordered Permutation*

Submitted by: Mohammad Sajid Anwar

You are given permutation of $n integers, @ints.

Write a script to find the minimum number of swaps needed to make the @ints a
semi-ordered permutation.

  A permutation is a sequence of integers from 1 to n of length n containing
  each number exactly once.
  A permutation is called semi-ordered if the first number is 1 and the last
  number equals n.

You are ONLY allowed to pick adjacent elements and swap them.

Example 1

  Input: @ints = (2, 1, 4, 3)
  Output: 2

  Swap 2 <=> 1 => (1, 2, 4, 3)
  Swap 4 <=> 3 => (1, 2, 3, 4)

Example 2

  Input: @ints = (2, 4, 1, 3)
  Output: 3

  Swap 4 <=> 1 => (2, 1, 4, 3)
  Swap 2 <=> 1 => (1, 2, 4, 3)
  Swap 4 <=> 3 => (1, 2, 3, 4)

Example 3

  Input: @ints = (1, 3, 2, 4, 5)
  Output: 0

  Already a semi-ordered permutation.

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
2. A permutation of integers 1 to n is entered on the command-line.
3. If $VERBOSE is set to a true value, the output is followed by details of the
   swaps required.

Algorithm
---------
To produce a semi-ordered permutation, the lowest integer (1) must be moved to
the beginning of the list, and the highest integer (n) must be moved to the end
of the list.

Let the initial indices of 1 and n be i and j, respectively. Then, since moves
are accomplished by swapping adjacent elements, it will require (i - 0) = i
swaps to move 1 to the beginning. Likewise, it will require ((n - 1) - j) swaps
to move n to the end. So the minimum number of swaps needed is (i + n - j - 1). 

However, if n is initially at a lower index than 1, then moving 1 to the left
will also accomplish one of the swaps required to move n to the right; in which
case, the minimum number of swaps needed is (i + n - j - 2).

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Array::Compare;
use Const::Fast;
use List::MoreUtils qw( firstidx );
use List::Util      qw( max min );
use Regexp::Common  qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A permutation of integers 1 to n
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 297, Task #2: Semi-Ordered Permutation (Perl)\n\n";
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
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ > 0                 or error( "$_ is not positive" );
        }

        is_permutation( \@ints )   or error( 'The input is not a permutation' );

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my @swaps;
        my $min_swaps = find_min_swaps( \@ints, $VERBOSE, \@swaps );

        print  "Output: $min_swaps\n";

        if ($VERBOSE && $min_swaps > 0)
        {
            print "\n";
            print "$_\n" for @swaps;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_min_swaps
#-------------------------------------------------------------------------------
{
    my ($ints, $verbose, $swaps) = @_;
    my  $min_idx   =  firstidx { $_ == min( @$ints ) } @$ints;
    my  $max_idx   =  firstidx { $_ == max( @$ints ) } @$ints;
    my  $min_swaps =  $min_idx + $#$ints - $max_idx;
      --$min_swaps if $max_idx < $min_idx;

    if ($verbose && $swaps)
    {
        my $listed_swaps = list_swaps( $ints, $swaps );

        $min_swaps == $listed_swaps
            or die "Listed swaps ($listed_swaps) != min swaps ($min_swaps)";
    }

    return $min_swaps;
}

#-------------------------------------------------------------------------------
sub list_swaps
#-------------------------------------------------------------------------------
{
    my ($ints, $swaps) = @_;
    my  $min_swaps     = 0;
    my  $min_idx       = firstidx { $_ == min( @$ints ) } @$ints;
    my  @perm          = @$ints;

    for my $i (reverse( 1 .. $min_idx ))
    {
        @perm[ $i, $i - 1 ] = @perm[ $i - 1, $i ];

        push @$swaps, sprintf "Swap %d <=> %d => (%s)", 
                      $perm[ $i ], $perm[ $i - 1 ], join ', ', @perm;

        ++$min_swaps;
    }

    my $max_idx = firstidx { $_ == max( @$ints ) } @perm;

    for my $j ($max_idx .. $#perm - 1)
    {
        @perm[ $j, $j + 1 ] = @perm[ $j + 1, $j ];

        push @$swaps, sprintf "Swap %d <=> %d => (%s)",
                      $perm[ $j + 1 ], $perm[ $j ], join ', ', @perm;

        ++$min_swaps;
    }

    return $min_swaps;
}

#-------------------------------------------------------------------------------
sub is_permutation
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  $n      = max @$ints;
    my  @sorted = sort { $a <=> $b } @$ints;
    my  $comp   = Array::Compare->new;

    return $comp->compare( \@sorted, [ 1 .. $n ] );
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

        my @ints  = split / \s+ /x, $ints_str;
        my $swaps = find_min_swaps( \@ints );

        is $swaps, $expected, $test_name;
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
Example 1|2 1 4 3  |2
Example 2|2 4 1 3  |3
Example 3|1 3 2 4 5|0
