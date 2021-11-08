use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 120
=========================

TASK #1
-------
*Swap Odd/Even bits*

Submitted by: Mohammad S Anwar

You are given a positive integer $N less than or equal to 255.

Write a script to swap the odd positioned bit with even positioned bit and
print the decimal equivalent of the new binary representation.

Example

 Input: $N = 101
 Output: 154

 Binary representation of the given number is 01 10 01 01.
 The new binary representation after the odd/even swap is 10 01 10 10.
 The decimal equivalent of 10011010 is 154.

 Input: $N = 18
 Output: 33

 Binary representation of the given number is 00 01 00 10.
 The new binary representation after the odd/even swap is 00 10 00 01.
 The decimal equivalent of 100001 is 33.

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
representations of $N and its odd/even-swapped counterpart. For example:

  Input: $N = 101 (01 10 01 01)
  Output:     154 (10 01 10 10)

Otherwise, only the decimal values will be shown:

  Input: $N = 101
  Output:     154

Algorithm
---------
1. Convert decimal $N to its 8-bit binary representation using sprintf '%08b'
2. Extract the odd/even binary pairs with a regular expression
3. Form $S-bin, the binary representation of the solution, by concatenating the
   nibbles in reverse order
4. Find the decimal equivalent of $S-bin using radix notation
5. Output the solution (with suitable vertical alignment for ease of viewing)

=end comment
#==============================================================================

my Bool constant $SHOW-BITS = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 120, Task #1: Swap Odd/Even bits (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N where { $N <= 255 }    #= A positive integer not greater than 255
)
#==============================================================================
{
    my UInt $N-dec =  $N + 0;                            # Decimal (normalized)
    my Str  $N-bin = '%08b'.sprintf: $N-dec;             # Binary
            $N-bin ~~ m:g/ (\d ** 2) /;                  # Extract the 4 odd/
    my Str  @pairs =  $/.map: { .Str };                  #    even binary pairs
    my Str  @swaps =  @pairs.map: { .flip };             # Swap each pair
    my Str  $S-bin =  @swaps.join;                       # ("S" for "swap")
    my UInt $S-dec =  :2( $S-bin );                      # Decimal
    my UInt $len-N =  $N-dec.chars;
    my UInt $len-S =  $S-dec.chars;
    my UInt $width =  $len-N >= $len-S ?? $len-N !! $len-S;

    "Input: \$N = %*d%s\nOutput:     %*d%s\n".printf:
        $width, $N-dec, $SHOW-BITS ?? ' (' ~ @pairs.join( ' ' ) ~ ')' !! '',
        $width, $S-dec, $SHOW-BITS ?? ' (' ~ @swaps.join( ' ' ) ~ ')' !! '';
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
