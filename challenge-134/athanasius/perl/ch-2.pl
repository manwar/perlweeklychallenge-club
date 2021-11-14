#!perl

###############################################################################
=comment

Perl Weekly Challenge 134
=========================

TASK #2
-------
*Distinct Terms Count*

Submitted by: Mohammad S Anwar

You are given 2 positive numbers, $m and $n.

Write a script to generate multiplcation table and display count of distinct
terms.

Example 1

 Input: $m = 3, $n = 3
 Output:

       x | 1 2 3
       --+------
       1 | 1 2 3
       2 | 2 4 6
       3 | 3 6 9

 Distinct Terms: 1, 2, 3, 4, 6, 9
 Count: 6

Example 2

 Input: $m = 3, $n = 5
 Output:

       x | 1  2  3  4  5
       --+--------------
       1 | 1  2  3  4  5
       2 | 2  4  6  8 10
       3 | 3  6  9 12 15

 Distinct Terms: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15
 Count: 11

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 <m> <n>

    <m>    Maximum row number
    <n>    Maximum column number\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 134, Task #2: Distinct Terms Count (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($m, $n) = parse_command_line();

    print "Input: \$m = $m, \$n = $n\n";

    my (@table, %terms);

    for my $row (1 .. $m)
    {
        for my $col (1 .. $n)
        {
            my $product = $row * $col;

            push @{ $table[ $row - 1 ] }, $product;

            ++$terms{ $product };
        }
    }

    print_table( $m, $n, \@table );

    printf "\nDistinct Terms: %s\nCount: %d\n",
        join( ', ', sort { $a <=> $b } keys %terms ), scalar keys %terms;
}

#------------------------------------------------------------------------------
sub print_table
#------------------------------------------------------------------------------
{
    my  ($m, $n, $table) = @_;
    my   @widths;
    push @widths, length $m;
    push @widths, length $_ for @{ $table->[ $m - 1 ] };

    my $width_sum  = 0;
       $width_sum += $_ for @widths[ 1 .. $#widths ];

    printf "\n      %*s |", $widths[ 0 ], 'x';

    printf ' %*d', $widths[ $_ ], $_ for 1 .. $n;

    printf "\n      %s+%s\n", '-' x ($widths[ 0 ] + 1),
                              '-' x ($width_sum   + $n);

    for my $row (1 .. $m)
    {
        printf '      %*s |', $widths[ 0 ], $table->[ $row - 1 ][ 0 ];

        printf ' %*d', $widths[ $_ ], $table->[ $row - 1 ][ $_ - 1 ]
            for 1 .. $n;

        print "\n";
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x
                  or error( qq["$_" is not a valid integer] );

        $_ > 0    or error( qq["$_" is not a positive integer] );
    }

    return @ARGV;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
