#!perl

################################################################################
=comment

Perl Weekly Challenge 068
=========================

Task #1
-------
*Zero Matrix*

*Submitted by:* Mohammad S Anwar

You are given a matrix of size M x N having only 0s and 1s.

Write a script to set the entire row and column to 0 if an element is 0.

*Example 1*

 Input: [1, 0, 1]
        [1, 1, 1]
        [1, 1, 1]

 Output: [0, 0, 0]
         [1, 0, 1]
         [1, 0, 1]

*Example 2*

 Input: [1, 0, 1]
        [1, 1, 1]
        [1, 0, 1]

 Output: [0, 0, 0]
         [1, 0, 1]
         [0, 0, 0]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Test::More;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print "Challenge 068, Task #1: Zero Matrix (Perl)\n\n";

    while (<DATA>)
    {
        my  ($M, $N, $input, $expected) = split;

        my  (@input, @expected);
        push @input,    [ split //, $1 ] while $input    =~ /(.{$N})/g;
        push @expected, [ split //, $1 ] while $expected =~ /(.{$N})/g;

        my   @actual = zero_matrix($M, $N, @input);

        is_deeply(\@actual, \@expected, "$M x $N array");
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub zero_matrix
#-------------------------------------------------------------------------------
{
    my ($rows, $cols, @array) = @_;
    my (%zero_rows, %zero_cols);

    for my $row (0 .. $rows - 1)
    {
        for my $col (0 .. $cols - 1)
        {
            if ($array[$row][$col] == 0)
            {
                ++$zero_rows{$row};
                ++$zero_cols{$col};
            }
        }
    }

    for my $row (keys %zero_rows)
    {
        $array[$row][$_] = 0 for 0 .. $cols - 1;
    }

    for my $col (keys %zero_cols)
    {
        $array[$_][$col] = 0 for 0 .. $rows - 1;
    }

    return @array;
}

################################################################################

__DATA__
3 3 101111111            000101101
3 3 101111101            000101000
2 4 11111110             11100000
4 5 11111111111011111111 10111101110000010111
2 3 111111               111111
1 7 1110111              0000000
