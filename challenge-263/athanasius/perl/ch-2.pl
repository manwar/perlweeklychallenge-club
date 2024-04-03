#!perl

################################################################################
=comment

Perl Weekly Challenge 263
=========================

TASK #2
-------
*Merge Items*

Submitted by: Mohammad Sajid Anwar

You are given two 2-D array of positive integers, $items1 and $items2 where
element is pair of (item_id, item_quantity).

Write a script to return the merged items.

Example 1

  Input: $items1 = [ [1,1], [2,1], [3,2] ]
         $items2 = [ [2,2], [1,3] ]
  Output: [ [1,4], [2,3], [3,2] ]

  Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
  Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
  Item id (3) appears 1 time: [3,2]

Example 2

  Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
         $items2 = [ [3,1], [1,3] ]
  Output: [ [1,8], [2,3], [3,3] ]

Example 3

  Input: $items1 = [ [1,1], [2,2], [3,3] ]
         $items2 = [ [2,3], [2,4] ]
  Output: [ [1,1], [2,9], [3,3] ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The "positive" integers include zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The 2-D lists $items1 and $items2 are entered as named-argument strings on
   the command-line.
 - Each string comprises items (pairs of positive integers) separated by white-
   space.
 - Within each item pair, item_id and item_quantity are separated by a single
   comma (no whitespace).

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
  perl $0 [--items1=<Str>] [--items2=<Str>]
  perl $0

    --items1=<Str>    1st space-separated list of comma-separated UInt pairs
    --items2=<Str>    2nd space-separated list of comma-separated UInt pairs
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 263, Task #2: Merge Items (Perl)\n\n";
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
        my ($items1, $items2) = parse_command_line();

        printf "Input: \$items1 = %s\n", display_items( $items1 );
        printf "       \$items2 = %s\n", display_items( $items2 );

        my $merged = merge_items( $items1, $items2 );

        printf "Output: merged = %s\n",  display_items( $merged );
    }
}

#-------------------------------------------------------------------------------
sub merge_items
#-------------------------------------------------------------------------------
{
    my ($items1, $items2) = @_;
    my  %quantity;

    for my $p (@$items1, @$items2)
    {
        $quantity{ $p->[ 0 ] } += $p->[ 1 ];
    }

    my @merged_items;

    for my $id (sort { $a <=> $b } keys %quantity)
    {
        push @merged_items, [ $id, $quantity{ $id } ];
    }

    return \@merged_items;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($items1_str, $items2_str);

    GetOptions
    (
        'items1=s' => \$items1_str,
        'items2=s' => \$items2_str
    
    ) or error( 'Invalid command-line arguments' );

    defined $items1_str or error( 'Missing items1' );
    defined $items2_str or error( 'Missing items2' );
    scalar  @ARGV == 0  or error( 'Extra command-line arguments' );

    my $items1 = parse_items_list( $items1_str );
    my $items2 = parse_items_list( $items2_str );

    return ($items1, $items2);
}

#-------------------------------------------------------------------------------
sub parse_items_list
#-------------------------------------------------------------------------------
{
    my ($items_str) = @_;
    my  @items;
    my  @item_strs  = split / \s+ /x, $items_str; 

    for my $item_str (@item_strs)
    {
        my  ($id, $quantity) = $item_str =~ / ^ ([^,]+) \, ([^,]+) $ /x
                    or error( qq[Malformed item pair "$item_str"] );

        for ($id, $quantity)
        {
            / ^ $RE{num}{int} $ /x
                    or error( qq["$_" is not a valid integer] );

            $_ >= 0 or error( qq["$_" is not a positive integer] );
        }

        push @items, [ $id, $quantity ];
    }

    return \@items;
}

#-------------------------------------------------------------------------------
sub display_items
#-------------------------------------------------------------------------------
{
    my ($items) = @_;

    return sprintf '[ %s ]',
                    join ', ', map { sprintf '[%s]', join ',', @$_ } @$items;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $items1_str, $items2_str, $expected_str) =
             split / \| /x, $line;

        for ($test_name, $items1_str, $items2_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $items1   = parse_items_list( $items1_str );
        my $items2   = parse_items_list( $items2_str );
        my $expected = parse_items_list( $expected_str );
        my $merged   = merge_items( $items1, $items2 );

        is_deeply $merged, $expected, $test_name;
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
Example 1|1,1 2,1 3,2    |2,2 1,3|1,4 2,3 3,2
Example 2|1,2 2,3 1,3 3,2|3,1 1,3|1,8 2,3 3,3
Example 3|1,1 2,2 3,3    |2,3 2,4|1,1 2,9 3,3
