#!perl

###############################################################################
=comment

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
binary representations of $N and its odd/even-swapped counterpart. For example:

  Input: $N = 101 (01 10 01 01)
  Output:     154 (10 01 10 10)

Otherwise, only the decimal values will be shown:

  Input: $N = 101
  Output:     154

Algorithm
---------
1. Convert decimal $N to its 8-bit binary representation using sprintf '%08b'
2. Extract the odd/even binary pairs with a regular expression
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
    print "\nChallenge 120, Task #1: Swap Odd/Even bits (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N_dec = parse_command_line();                        # Decimal
    my $N_bin = sprintf '%08b', $N_dec;                      # Binary
    my @pairs = $N_bin =~ / ( \d{2} ) /gx;                   # Odd/even pairs
    my @swaps = map { scalar reverse } @pairs;
    my $S_bin = join '', @swaps;                             # ("S" for "swap")
    my $S_dec = oct "0b$S_bin";                              # Decimal
    my $len_N = length $N_dec;
    my $len_S = length $S_dec;
    my $width = $len_N >= $len_S ? $len_N : $len_S;

    printf "Input: \$N = %*d%s\nOutput:     %*d%s\n",
            $width, $N_dec, $SHOW_BITS ? ' (' . join(' ', @pairs) . ')' : '',
            $width, $S_dec, $SHOW_BITS ? ' (' . join(' ', @swaps) . ')' : '';
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
