#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Usage
-----
If the constant $SHOW_BITS is set to a true value, the output will include
binary representations of the nibbles in $N and its nibble-swapped counterpart.
For example:

  Input: $N = 101 (0110)(0101)
  Output:      86 (0101)(0110)

Otherwise, only the decimal values will be shown:

  Input: $N = 101
  Output:      86

Algorithm
---------
1. Convert decimal $N to its 8-bit binary representation using sprintf '%08b'
2. Extract the 2 nibbles with a regular expression
3. Form $S_bin, the binary representation of the solution, by concatenating the
   nibbles in reverse order
4. Find the decimal equivalent of $S_bin by using oct with an argument formed
   by prefixing '0b' to $S_bin (this indicates to the built-in oct function
   that its argument is a binary number)
5. Output the solution (with suitable vertical alignment for ease of viewing)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $SHOW_BITS => 1;
const my $USAGE     =>
"Usage:
  perl $0 <N>

    <N>    A positive integer not greater than 255\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 119, Task #1: Swap Nibbles (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N_dec = parse_command_line();                            # Decimal
    my $N_bin = sprintf '%08b', $N_dec;                          # Binary
    my @nibs  = $N_bin =~ / (\d{4}) (\d{4}) /x;                  # Nibbles
    my $S_bin = $nibs[ 1 ] . $nibs[ 0 ];                         # S for "swap"
    my $S_dec = oct "0b$S_bin";
    my $len_N = length $N_dec;
    my $len_S = length $S_dec;
    my $width = $len_N >= $len_S ? $len_N : $len_S;

    printf "Input: \$N = %*d%s\nOutput:     %*d%s\n",
            $width, $N_dec, $SHOW_BITS ? " ($nibs[ 0 ])($nibs[ 1 ])" : '',
            $width, $S_dec, $SHOW_BITS ? " ($nibs[ 1 ])($nibs[ 0 ])" : '';
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $N =  $ARGV[ 0 ];
       $N =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$N" is not a valid integer] );
       $N +=   0;                                 # Normalize: e.g., 010 --> 10
       $N >=   0  or error( "$N is less than 0" );
       $N <= 255  or error( "$N is greater than 255" );

    return $N;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
