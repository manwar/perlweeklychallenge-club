use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 121
=========================

TASK #1
-------
*Invert Bit*

Submitted by: Mohammad S Anwar

You are given integers 0 <= $m <= 255 and 1 <= $n <= 8.

Write a script to invert $n bit from the end of the binary representation of $m
and print the decimal representation of the new binary number.

Example

 Input: $m = 12, $n = 3
 Output: 8

 Binary representation of $m = 00001100
 Invert 3rd bit from the end = 00001000
 Decimal equivalent of 00001000 = 8

 Input $m = 18, $n = 4
 Output: 26

 Binary representation of $m = 00010010
 Invert 4th bit from the end = 00011010
 Decimal equivalent of 00011010 = 26

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 121, Task #1: Invert Bit (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Int:D $m where { 0 <= $m <= 255 }, #= Decimal: an integer between 0 and 255
    Int:D $n where { 1 <= $n <=   8 }  #= Bit count: an integer between 1 and 8
)
#==============================================================================
{
    "Input:  \$m = %d, \$n = %d\n".printf: $m + 0, $n + 0;          # Normalize

    my Str  $m-bin = '%08b'.sprintf: $m;
    my UInt @bin   = $m-bin.split( '', :skip-empty ).map: { .Int };
    my UInt $idx   = 8 - $n;
      @bin[ $idx ] = @bin[ $idx ] == 1 ?? 0 !! 1;
    my Str  $s-bin = @bin.join;
    my UInt $s-dec = :2( $s-bin );

    "Output: $s-dec".put;

    if $VERBOSE
    {
        ("\nBinary representation of \$m = %s\n" ~
           "Invert %d%s bit from the end = %s\n" ~
           "And the decimal equivalent of %s = %d\n").printf:
                $m-bin,  $n, ($n == 1 ?? 'st' !!
                              $n == 2 ?? 'nd' !!
                              $n == 3 ?? 'rd' !! 'th'), $s-bin, $s-bin, $s-dec;
    }
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
