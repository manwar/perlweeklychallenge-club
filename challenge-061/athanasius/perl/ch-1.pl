#!perl

################################################################################
=comment

Perl Weekly Challenge 061
=========================

Task #1
-------
*Product SubArray*

*Reviewed by: Ryan Thompson*

Given a list of *4 or more* numbers, write a script to find the contiguous
sublist that has the maximum product. The length of the sublist is irrelevant;
your job is to maximize the product.

*Example*
Input: [ 2, 5, -1, 3 ]

Output: [ 2, 5 ] which gives maximum product 10.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Scalar::Util qw( looks_like_number );

const my $MIN_ARGS => 4;
const my $USAGE    => "USAGE: perl $0 <Number>{$MIN_ARGS+}";

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
    print "Challenge 061, Task #1: Product SubArray (Perl)\n\n";

    my $args =  scalar @ARGV;
       $args >= $MIN_ARGS
            or die "ERROR: Missing command-line arguments ($args found)\n\n" .
                   "$USAGE\n";

    looks_like_number($_) && !/ ^ NaN $ /ix
            or die "ERROR: Invalid command-line argument: $_\n\n$USAGE\n"
                for @ARGV;

    my ($sublist, $product) = product_subarray(@ARGV);

    printf "Input:  [%s]\nOutput: [%s] which gives maximum product %.1f\n",
            join(', ', @ARGV), join(', ', @$sublist), $product;
}

#-------------------------------------------------------------------------------
sub product_subarray
#-------------------------------------------------------------------------------
{
    my @list        =  @_;
    my @max_sublist = ($list[0]);
    my $max_product =  $list[0];

    for my $i (0 .. $#list)
    {
        my @sublist = ($list[$i]);
        my $product =  $list[$i];

        if (($product >  $max_product) ||
            ($product == $max_product  &&
             scalar @sublist < scalar @max_sublist))
        {
            @max_sublist = @sublist;
            $max_product = $product;
        }

        for my $j ($i + 1 .. $#list)
        {
            push @sublist, $list[$j];
            $product  *=   $list[$j];

            if (($product >  $max_product) ||
                ($product == $max_product  &&
                 scalar @sublist < scalar @max_sublist))
            {
                @max_sublist = @sublist;
                $max_product = $product;
            }
        }
    }

    return (\@max_sublist, $max_product);
}

################################################################################
