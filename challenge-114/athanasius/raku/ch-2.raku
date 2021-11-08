use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 114
=========================

TASK #2
-------
*Higher Integer Set Bits*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to find the next higher integer having the same number of 1 bits
in binary representation as $N.

Example

 Input: $N = 3
 Output: 5

 Binary representation of $N is 011. There are two 1 bits. So the next higher
 integer is 5 having the same the number of 1 bits i.e. 101.

 Input: $N = 12
 Output: 17

 Binary representation of $N is 1100. There are two 1 bits. So the next higher
 integer is 17 having the same number of 1 bits i.e. 10001.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Output
------
With DEBUG set to True, the output includes the binary forms of N and the
solution S, together with a count of their 1-bits. If this extra information is
not wanted, set DEBUG to False and the output will show N and S only.

Algorithm
---------
0. Input N
1. Convert N to its binary form, N-bin
     Let d be the number of   digits in N-bin
     Let n be the number of 1-digits in N-bin
2. IF
     Any 0-digit (in position z within N-bin) lies between 1-digits,
   THEN
     S-bin is constructed as follows:
       2.1 the digits above z in N-bin remain unchanged
       2.2 the digit at z becomes 1
       2.3 the remaining complement (n - 2) of 1-digits occupy the least
           significant places in S-bin
       2.4 any remaining digits between z and the group of least significant
           1-digits are set to zero, bringing S-bin up to a total of d digits
3. ELSE
     S-bin is constructed as follows:
       3.1 an initial 1-digit
       3.2 the remaining complement (n - 1) of 1-digits in the least
           significant places
       3.3 0-digits for padding, bringing S-bin up to a total of (d + 1) digits
   ENDIF
4. Convert S-bin to its decimal form, S
5. Output S

(Note that a brute force approach -- set S to N + 1 and continue to increment S
until the number of 1-digits in S-bin equals d -- works well for smaller values
of N and for certain larger values, but becomes unacceptably slow for large
values of N where N is a power of 2.)

=end comment
#==============================================================================

subset Positive of Int where * > 0;

my Bool constant DEBUG = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 114, Task #2: Higher Integer Set Bits (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Positive:D $N               #= A non-zero, positive integer
)
#==============================================================================
{
    my Positive $n      = $N + 0;                                   # Normalize

    "Input: \$N = $n".put unless DEBUG;

    my Str      $n-bin  =  $n.base( 2 );
    my Positive $n-ones = +$n-bin.comb: '1';
    my Str      $s-bin  =  solve( $n, $n-bin, $n-ones );
    my Positive $s      = ":2<$s-bin>".Int;

    if DEBUG
    {
        "Input: \$N = %*d (%d one-bit%s: %*b)\n".printf: $s.chars, $n, $n-ones,
            ($n-ones == 1 ?? '' !! 's'), $s-bin.chars, $n;

        my Positive $s-bits = +$s-bin.comb: '1'; #$s-bin =~ tr/1//;

        "Output:     %d (%d one-bit%s: %s)\n".printf: $s, $s-bits,
            ($s-bits == 1 ?? '' !! 's'), $s-bin;
    }
    else
    {
        "Output:     $s".put;
    }
}

#------------------------------------------------------------------------------
sub solve
(
    Positive:D $n,
    Str:D      $n-bin,
    Positive:D $n-ones
--> Str:D
)
#------------------------------------------------------------------------------
{
    my Str  @n-digits = $n-bin.split: '', :skip-empty;
    my Bool $found1   = False;
    my Str  $s-bin    = '1';
    my UInt $zero-i;

    for (1 .. @n-digits.end).reverse -> UInt $i
    {
        if $found1
        {
            $zero-i = $i, last if @n-digits[ $i ] == 0;
        }
        else
        {
            $found1 = True     if @n-digits[ $i ] == 1;
        }
    }

    if $zero-i.defined
    {
        $s-bin ~= $n-bin.substr: 1, $zero-i - 1;
        $s-bin ~= '1';

        my UInt $ones-diff = $n-ones - +$s-bin.comb: '1';

        $s-bin ~= '0' x ($n-bin.chars - $s-bin.chars - $ones-diff);
        $s-bin ~= '1' x  $ones-diff;
    }
    else
    {
        $s-bin ~= '0' x ($n-bin.chars - $n-ones + 1);
        $s-bin ~= '1' x ($n-ones - 1);
    }

    return $s-bin;
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
