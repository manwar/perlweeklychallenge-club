#!perl

###############################################################################
=comment

Perl Weekly Challenge 140
=========================

TASK #2
-------
*Multiplication Table*

Submitted by: Mohammad S Anwar

You are given 3 positive integers, $i, $j and $k.

Write a script to print the $kth element in the sorted multiplication table of
$i and $j.

Example 1

  Input: $i = 2; $j = 3; $k = 4
  Output: 3

  Since the multiplication of 2 x 3 is as below:

      1 2 3
      2 4 6

  The sorted multiplication table:

      1 2 2 3 4 6

  Now the 4th element in the table is "3".

Example 2

  Input: $i = 3; $j = 3; $k = 6
  Output: 4

  Since the multiplication of 3 x 3 is as below:

      1 2 3
      2 4 6
      3 6 9

  The sorted multiplication table:

      1 2 2 3 3 4 6 6 9

  Now the 6th element in the table is "4".

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumption
----------
A "positive integer" is an integer greater than or equal to one.

Configuration
-------------
Set $VERBOSE to a true value (the default) to display an explanation of the
output like that in the Examples. Set it to a false value to remove the explan-
ation.

Algorithm
---------
(Straightforward:) construct the multiplication table; sort it in ascending
numerical order; then index it to obtain the desired output.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <i> <j> <k>

    <i>    Positive integer: maximum multiplier   for the  table
    <j>    Positive integer: maximum multiplicand for the  table
    <k>    Positive integer: 1-based index into the sorted table\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 140, Task #2: Multiplication Table (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($i, $j, $k) = parse_command_line();

    print "Input:  \$i = $i; \$j = $j; \$k = $k\n";

    my @table;

    for my $row (1 .. $i)                              # Construct the table
    {
        for my $col (1 .. $j)
        {
            push @table, $col * $row;
        }
    }

    my @sorted  = sort { $a <=> $b } @table;           # Sort the table
    my $element = $sorted[ $k - 1 ];                   # Index the sorted table

    print "Output: $element\n";

    explain( $i, $j, $k, \@table, \@sorted, $element ) if $VERBOSE;
}

#------------------------------------------------------------------------------
sub explain
#------------------------------------------------------------------------------
{
    my ($i, $j, $k, $table, $sorted, $element) = @_;

    print "\nSince the multiplication of $i x $j is as below:\n";

    # (1) Pre-compute table column widths

    my @widths;

    for my $idx (($i - 1) * $j .. $i * $j - 1)
    {
        push @widths, length $table->[ $idx ];
    }

    # (2) Print the table

    for my $row (0 .. $i - 1)
    {
        print '   ';

        for my $idx ($row * $j .. ($row + 1) * $j - 1)
        {
            printf ' %*d', $widths[ $idx % $j ], $table->[ $idx ];
        }

        print "\n";
    }

    # (3) Print the contents of the sorted table

    printf "\nThe sorted multiplication table:\n\n    %s\n",
            join ' ', @$sorted;

    # (4) Explain the output

    printf qq[\nNow the %s element in the table is "%d".\n],
           ordinal( $k ), $element;
}

#------------------------------------------------------------------------------
sub ordinal
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  $suffix = 'th';
    my  $digit0 = substr $n, -1, 1;

    if (length $n < 2 || substr( $n, -2, 1 ) ne '1')
    {
        $suffix = $digit0 eq '1' ? 'st' :
                  $digit0 eq '2' ? 'nd' :
                  $digit0 eq '3' ? 'rd' : 'th';
    }

    return $n . $suffix;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 3 or error( "Expected 3 command line arguments, found $args" );

    my ($i, $j, $k) = @ARGV;

    for my $n ($i, $j, $k)
    {
        $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

        $n > 0    or error( qq["$n" is not positive] );
    }

    # Check that $k is a valid index

    $k <= $i * $j or error( "\$k = $k is too large" );

    return ($i, $j, $k);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
