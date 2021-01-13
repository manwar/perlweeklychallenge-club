use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant MIN-ARGS = 4;

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    #| 4 or more Real numbers (may include Inf, but not NaN)

    *@nums where { $_.all ~~ Real:D && @nums.elems >= MIN-ARGS }
)
#===============================================================================
{
    "Challenge 061, Task #1: Product SubArray (Raku)\n".put;

    my Array[Real] $list = Array[Real].new: @nums.map: { .Real };

    $_ === NaN
        and die "ERROR: Invalid command-line argument \"NaN\"\n$*USAGE\n"
            for $list.values;

    my (Array[Real] $sublist, Real $product) = product-subarray($list);

    "Input:  [%s]\nOutput: [%s] which gives maximum product %.1f\n".printf:
        $list.join(', '), $sublist.join(', '), $product;
}

#-------------------------------------------------------------------------------
sub product-subarray( Array[Real] $list --> List )
#-------------------------------------------------------------------------------
{
    my Array[Real] $max-sublist = Array[Real].new: $list[0];
    my Real        $max-product = $list[0];

    for $list.keys -> UInt $i
    {
        my Array[Real] $sublist = Array[Real].new: $list[$i];
        my Real        $product = $list[$i];

        if  $product >  $max-product ||
           ($product == $max-product &&
            $sublist.elems < $max-sublist.elems)
        {
            $max-sublist = $sublist.clone;
            $max-product = $product;
        }

        for $i + 1 .. $list.end -> UInt $j
        {
            $sublist.push: $list[$j];
            $product  *=   $list[$j];

            if  $product >  $max-product ||
               ($product == $max-product &&
                $sublist.elems < $max-sublist.elems)
            {
                $max-sublist = $sublist.clone;
                $max-product = $product;
            }
        }
    }

    return $max-sublist, $max-product;
}

###############################################################################
