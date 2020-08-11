use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 070
=========================

Task #2
-------
*Gray Code Sequence*

*Submitted by:* Mohammad S Anwar

You are given an integer 2 <= $N <= 5.

Write a script to generate $N-bit 
[https://www.tutorialspoint.com/what-is-gray-code | gray code sequence].

*2-bit Gray Code Sequence*

 [0, 1, 3, 2]

To generate the 3-bit Gray code sequence from the 2-bit Gray code sequence,
follow the step below:

 2-bit Gray Code sequence
 [0, 1, 3, 2]

 Binary form of the sequence
 a) S1 = [00, 01, 11, 10]

 Reverse of S1
 b) S2 = [10, 11, 01, 00]

 Prefix all entries of S1 with '0'
 c) S1 = [000, 001, 011, 010]

 Prefix all entries of S2 with '1'
 d) S2 = [110, 111, 101, 100]

 Concatenate S1 and S2 gives 3-bit Gray Code sequence
 e) [000, 001, 011, 010, 110, 111, 101, 100]

 3-bit Gray Code sequence
 [0, 1, 3, 2, 6, 7, 5, 4]

*Example*

 Input: $N = 4

 Output: [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Array[Str:D] constant ONE-BIT-SEQ = Array[Str:D].new: < 0 1 >;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 070, Task #2: Gray Code Sequence (Raku)\n".put;
}

#===============================================================================
sub MAIN
(
    UInt:D $N where { 2 ≤ $N ≤ 5 }      #= Number of bits: integer >= 2 and <= 5
)
#===============================================================================
{
    "Input:  \$N = $N\n".put;

    my UInt @gray-codes = gray-codes-binary($N).map: { "0b$_".UInt };

    "Output: [%s]\n".printf: @gray-codes.join: ', ';
}

#-------------------------------------------------------------------------------
sub gray-codes-binary
(
    UInt:D $N where { $N >= 1 }                  #= Number of bits: integer >= 1
--> Array:D[Str:D]
)
#-------------------------------------------------------------------------------
{
    return ONE-BIT-SEQ if $N == 1;               # Base case

    my Str @seq = gray-codes-binary($N - 1);     # Recursive call
    my Str @s1  = @seq        .map: { "0$_" };
    my Str @s2  = @seq.reverse.map: { "1$_" };

    @s1.append: @s2;                             # Concatenate the arrays

    return @s1;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
