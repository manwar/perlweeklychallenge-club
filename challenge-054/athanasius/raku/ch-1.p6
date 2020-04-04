use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 054
=========================

Task #1
*kth Permutation Sequence*

Write a script to accept two integers *n (>=1)* and *k (>=1)*. It should print
the *kth permutation* of *n integers*. For more information, please follow the
[ https://en.wikipedia.org/wiki/Permutation#k-permutations_of_n |wiki page].

For example, *n=3* and *k=4*, the possible permutation sequences are listed
below:

  123
  132
  213
  231
  312
  321

The script should print the *4th* permutation sequence *231*.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN
(
    #| Integer >= 1, upper bound of integer series 1..N to be permuted
    UInt:D $N where $_ >= 1,

    #| Integer >= 1, the number of the required permutation of the series
    UInt:D $K where $_ >= 1,
)
#===============================================================================
{
    "Challenge 054, Task #1: kth Permutation Sequence (Raku)\n".put;

    my UInt @list  = 1 .. $N;
    my UInt $size  = [*] @list;
    my UInt $index = ($K - 1) % $size;
    my List $perm  = @list.permutations[ $index ];
    my Str  $sep   = $N < 10 ?? '' !! ' ';

    "The %s permutation of %s is %s\n".printf:
        ordinal($K), (1 .. $N).join($sep), $perm.list.join($sep);
}

#-------------------------------------------------------------------------------
sub ordinal(UInt:D $n --> Str:D)
#-------------------------------------------------------------------------------
{
    my Str  $suffix = 'th';
    my UInt $dig1   = (($n % 100) / 10).UInt;

    unless $dig1 == 1
    {
        my UInt $dig0 = $n % 10;

        $suffix = $dig0 == 1 ?? 'st' !!
                  $dig0 == 2 ?? 'nd' !!
                  $dig0 == 3 ?? 'rd' !! 'th';
    }

    return $n ~ $suffix;
}

###############################################################################
