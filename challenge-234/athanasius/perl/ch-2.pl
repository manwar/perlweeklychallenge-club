#!perl

################################################################################
=comment

Perl Weekly Challenge 234
=========================

TASK #2
-------
*Unequal Triplets*

Submitted by: Mohammad S Anwar

You are given an array of positive integers.

Write a script to find the number of triplets (i, j, k) that satisfies num[i] !=
num[j], num[j] != num[k] and num[k] != num[i].

Example 1

  Input: @ints = (4, 4, 2, 4, 3)
  Output: 3

  (0, 2, 4) because 4 != 2 != 3
  (1, 2, 4) because 4 != 2 != 3
  (2, 3, 4) because 2 != 4 != 3

Example 2

  Input: @ints = (1, 1, 1, 1, 1)
  Output: 0

Example 3

  Input: @ints = (4, 7, 1, 10, 7, 4, 1, 1)
  Output: 28

  triplets of 1, 4, 7  = 3x2×2 = 12 combinations
  triplets of 1, 4, 10 = 3×2×1 = 6  combinations
  triplets of 4, 7, 10 = 2×2×1 = 4  combinations
  triplets of 1, 7, 10 = 3x2x1 = 6  combinations

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
A "positive" integer is greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), the output is followed by
   an explanation like that in Example 3.

=cut
#===============================================================================

use strict;
use warnings;
use Algorithm::Combinatorics qw( combinations );
use Const::Fast;
use List::MoreUtils          qw( mesh );
use Regexp::Common           qw( number );
use Test::More;

const my $PRODUCT => 6;
const my $SIZE    => 3;
const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 234, Task #2: Unequal Triplets (Perl)\n\n";
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
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer]  );
            $_ > 0                 or error( qq[$_ is not a positive integer] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my @table;
        my $count = count_unequal_triplets( \@ints, $VERBOSE, \@table );

        print "Output: $count\n";

        print_table( \@table ) if $VERBOSE && $count > 0;
    }
}

#-------------------------------------------------------------------------------
sub count_unequal_triplets
#-------------------------------------------------------------------------------
{
    my ($ints, $verbose, $table) = @_;
    my  %dict;
      ++$dict{ $_ } for @$ints;

    my  $count = 0;
    my  @keys  = sort { $a <=> $b } keys %dict;

    if (scalar @keys >= $SIZE)
    {
        my $iter = combinations( \@keys, $SIZE );

        while (my $comb = $iter->next)
        {
            my ($i, $j, $k) = @$comb;

            my $ival = $dict{ $i };
            my $jval = $dict{ $j };
            my $kval = $dict{ $k };
            my $prod = $ival * $jval * $kval;

            $count += $prod;

            push @$table, [ $i, $j, $k, $ival, $jval, $kval, $prod ]
                if $verbose;
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub print_table
#-------------------------------------------------------------------------------
{
    my ($table)  = @_;
    my  $max_row = $#$table;
    my  $max_col = scalar @{ $table->[ 0 ] } - 1;
    my  @widths;

    # Calculate maximum column widths

    for my $col (0 .. $max_col)
    {
        $widths[ $col ] = length $table->[ 0 ][ $col ];

        for my $row (1 .. $max_row)
        {
            my $new_len = length $table->[ $row ][ $col ];

            $widths[ $col ] = $new_len if $new_len > $widths[ $col ];
        }
    }

    # Print the table

    print "\n";

    for my $row_data (@$table)
    {
        my $prod = $row_data->[ $PRODUCT ];

        printf 'Triplet (%*d, %*d, %*d) occurs in %*d×%*d×%*d = %*d ' .
               "combination%s\n",
                mesh( @widths, @$row_data ), $prod == 1 ? '' : 's';
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $int_str;
        my $count = count_unequal_triplets( \@ints, 0, undef );

        is $count, $exp_str, $test_name;
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
Example 1|4 4 2  4 3      | 3
Example 2|1 1 1  1 1      | 0
Example 3|4 7 1 10 7 4 1 1|28
