#!perl

################################################################################
=comment

Perl Weekly Challenge 218
=========================

TASK #1
-------
*Maximum Product*

Submitted by: Mohammad S Anwar

You are given a list of 3 or more integers.

Write a script to find the 3 integers whose product is the maximum and return
it.

Example 1

  Input: @list = (3, 1, 2)
  Output: 6

  1 x 2 x 3 => 6

Example 2

  Input: @list = (4, 1, 3, 2)
  Output: 24

  2 x 3 x 4 => 24

Example 3

  Input: @list = (-1, 0, 1, 3, 1)
  Output: 3

  1 x 1 x 3 => 3

Example 4

  Input: @list = (-8, 2, -9, 0, -4, 3)
  Output: 216

  -9 × -8 × 3 => 216

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), the output is followed by
   an explanation of the result.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use List::MoreUtils qw( part reduce_1 );
use Regexp::Common  qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of 3 or more integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 218, Task #1: Maximum Product (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args <  3)
    {
        error( "Expected 0 or 3+ command-line arguments, found $args" )
    }
    else
    {
        / ^ $RE{num}{int} $ /x or error( qq[Invalid integer "$_"] ) for @ARGV;

        printf "Input:  \@list = %s\n", join ', ', @ARGV;

        my $solution    = [];
        my $max_product = find_max_product( \@ARGV, $solution );

        print "Output: $max_product\n";

        printf( "\n%s = $max_product\n", join( ' x ', @$solution ) ) if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub find_max_product
#-------------------------------------------------------------------------------
{
    my ($list, $soln) = @_;
    my  @partition    = part { $_ >= 0 } @$list;            # Partition the list
    my  @negatives    = @{ $partition[ 0 ] // [] };
    my  @positives    = @{ $partition[ 1 ] // [] };
    my  $n_negatives  = scalar @negatives;
    my  $n_positives  = scalar @positives;

    @negatives = sort { $a <=> $b } @negatives;             # Ascending
    @positives = sort { $b <=> $a } @positives;             # Descending

    if    (scalar @$list == 3 || $n_negatives < 2 || $n_positives == 0)
    {
        @$soln = (sort { $a <=> $b } @$list )[ -3 .. -1 ];
    }
    elsif ($n_positives < 3)
    {
        @$soln = (@negatives[ 0 .. 1 ], $positives[ 0 ]);
    }
    else
    {
        my @neg_soln = (@negatives[ 0 .. 1 ], $positives[ 0 ]);
        my @pos_soln =  @positives[ 0 .. 2 ];
        my $neg_prod =  reduce_1 { $a *= $b } @neg_soln;    # Product 1
        my $pos_prod =  reduce_1 { $a *= $b } @pos_soln;    # Product 2

        @$soln = $neg_prod > $pos_prod ? @neg_soln : @pos_soln;
    }

    return reduce_1 { $a *= $b } @$soln;                    # Max product
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($name, $list_str, $expected, $soln_str) = split / \| /x, $line;

        for ($name, $list_str, $expected, $soln_str)           # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $solution = [];
        my @list     = split / , \s* /x, $list_str;
        my @soln     = split / , \s* /x, $soln_str;
        my $got      = find_max_product( \@list, $solution );

        is        $got,      $expected, $name;
        is_deeply $solution, \@soln,    $name if $VERBOSE;
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
Example 1  | 3,  1,  2          |  6| 1,  2,  3
Example 2  | 4,  1,  3, 2       | 24| 2,  3,  4
Example 3  |-1,  0,  1, 3,  1   |  3| 1,  1,  3
Example 4  |-8,  2, -9, 0, -4, 3|216|-9, -8,  3
Negative 1 |-2, -3, -1          | -6|-3, -2, -1
Negative 2 |-2, -3, -1, -10, -10| -6|-3, -2, -1
Min mixed 1|-1,  5,  2          |-10|-1,  2,  5
Min mixed 2|-1,  5, -2          | 10|-2, -1,  5
1 negative | 1,  2,  3,   7,  -4| 42| 2,  3,  7
2 negatives| 1,  2,  3,  -7,  -4| 84|-7, -4,  3
3 negatives| 1, -2,  3,  -7,  -4| 84|-7, -4,  3
Duplicates | 4,  0,  4,   5,  -3| 80| 4,  4,  5
