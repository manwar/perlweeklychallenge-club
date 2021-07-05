use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 119
=========================

TASK #1
-------
*Swap Nibbles*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to swap the two nibbles of the binary representation of the
given number and print the decimal number of the new binary representation.

    A nibble is a four-bit aggregation, or half an octet.

To keep the task simple, we only allow integer less than or equal to 255.

Example

 Input: $N = 101
 Output: 86

 Binary representation of decimal 101 is 1100101 or as 2 nibbles (0110)(0101).
 The swapped nibbles would be (0101)(0110) same as decimal 86.

 Input: $N = 18
 Output: 33

 Binary representation of decimal 18 is 10010 or as 2 nibbles (0001)(0010).
 The swapped nibbles would be (0010)(0001) same as decimal 33.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Usage
-----
If the constant $SHOW-BITS is set to True, the output will include binary
representations of the nibbles in $N and its nibble-swapped counterpart. For
example:

  Input: $N = 101 (0110)(0101)
  Output:      86 (0101)(0110)

Otherwise, only the decimal values will be shown:

  Input: $N = 101
  Output:      86

Algorithm
---------
1. Convert decimal $N to its 8-bit binary representation using sprintf '%08b'
2. Extract the 2 nibbles with a regular expression
3. Form $S-bin, the binary representation of the solution, by concatenating the
   nibbles in reverse order
4. Find the decimal equivalent of $S-bin using the adverbial form :2( $S-bin )
   which interprets $S-bin as a binary (base 2) number representation
5. Output the solution (with suitable vertical alignment for ease of viewing)

=end comment
#==============================================================================

my Bool constant $SHOW-BITS = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 119, Task #1: Swap Nibbles (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N where { $N <= 255 }    #= A positive integer not greater than 255
)
#==============================================================================
{
    my UInt $N-dec =  $N + 0;        # Normalize: e.g., 010 --> 10, 0x10 --> 16
    my Str  $N-bin = '%08b'.sprintf: $N-dec;                  # Binary
            $N-bin ~~ rx/ (\d ** 4) (\d ** 4) /;              # Extract nibbles
    my Str  @nibs  =  @$/.map: { .Str };
    my Str  $S-bin =  @nibs[ 1 ] ~ @nibs[ 0 ];                # S for "swap"
    my UInt $S-dec =  :2( $S-bin );
    my UInt $len-N =  $N-dec.chars;
    my UInt $len-S =  $S-dec.chars;
    my UInt $width =  $len-N >= $len-S ?? $len-N !! $len-S;

    "Input: \$N = %*d%s\nOutput:     %*d%s\n".printf:
        $width, $N-dec, $SHOW-BITS ?? " (@nibs[ 0 ])(@nibs[ 1 ])" !! '',
        $width, $S-dec, $SHOW-BITS ?? " (@nibs[ 1 ])(@nibs[ 0 ])" !! '';
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

##############################################################################
