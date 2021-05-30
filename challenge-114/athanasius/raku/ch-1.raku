use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 114
=========================

TASK #1
-------
*Next Palindrome Number*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find out the next Palindrome Number higher than the given
integer $N.

Example

 Input: $N = 1234
 Output: 1331

 Input: $N = 999
 Output: 1001

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------

Let N have digits abc...klm[n]opq...xyz, where m is the middle digit (if N has
an odd number of digits), or the first of 2 middle digits mn (if N has an even
number of digits).

First, we form the palindromic number S:

    S = abc...klm[m]lk...cba

by reversing the first (i.e., left, or most significant) half of N's digits. If
S > N, it must be the solution since it has been constructed as the smallest
palindromic number > N.

If S <= N, it will be necessary to increment one of the digits abc...klm. To
form the smallest number, we begin with the the least significant digit, namely
m. If m < 9, M = m + 1 is guaranteed to produce a palindromic number T greater
than N but smaller than any other palindromic number greater than N:

    T = abc...klM[M]lk...cba

If m = 9, we set m = 0 and increment l (L = l + 1) to form U:

    U = abc...kL0[0]Lk...cba

But if L is also 9, we increment k; and so on down to c, b, a. Finally, if a
solution has still not been found and a is also 9, we need to construct a new
palindromic number V with one more digit than N. The smallest such palindromic
number has the form:

    V = 1000...0001

with the first and last digits set to 1 and all other digits set to 0.

=end comment
#==============================================================================

subset Digit of Int where 0 <= * <= 9;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 114, Task #1: Next Palindrome Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N                      #= A positive integer
)
#==============================================================================
{
    my UInt  $n        = $N + 0;              # Normalize (e.g. 010 becomes 10)

    "Input: \$N = $n".put;

    my Digit @digits   = $n.split( '', :skip-empty ).map: { .Int };
    my UInt  $num-digs = @digits.elems;
    my Bool  $is-even  = $num-digs % 2 == 0;
    my UInt  $mid-i    = floor( ($num-digs / 2) + ($is-even ?? -0.5 !! 0) );
    my Int   $mid-j    = $is-even ?? $mid-i !! $mid-i - 1;
    my Digit @mirror   = @digits[ 0 .. $mid-i ];
         @mirror.append: @digits[ 0 .. $mid-j ].reverse;
    my UInt  $solution = @mirror.join( '' ).Int;

    if $solution <= $N
    {
        for (0 .. $mid-i).reverse -> UInt $i
        {
            my UInt $j = @digits.end - $i;

            if  @mirror[ $i ] == 9
            {
                @mirror[ $i ] =   @mirror[ $j ] = 0;
            }
            else
            {
                @mirror[ $j ] = ++@mirror[ $i ];
                last;
            }
        }

        $solution = (@mirror[ 0 ] == 0 ?? '1' ~ '0' x ($num-digs - 1) ~ '1'
                                       !!  @mirror.join: '').Int;
    }

    "Output:     $solution".put;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
