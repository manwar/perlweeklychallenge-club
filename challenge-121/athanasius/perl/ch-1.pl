#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <m> <n>

    <m>    Decimal: an integer between 0 and 255
    <n>    Bit count: an integer between 1 and 8\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 121, Task #1: Invert Bit (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($m, $n) = parse_command_line();

    print "Input:  \$m = $m, \$n = $n\n";

    my $m_bin = sprintf '%08b', $m;
    my @bin   = split '', $m_bin;
    my $idx   = 8 - $n;

    $bin[ $idx ] = $bin[ $idx ] == 1 ? 0 : 1;

    my $s_bin = join '', @bin;
    my $s_dec = oct "0b$s_bin";

    print "Output: $s_dec\n";

    if ($VERBOSE)
    {
        printf "\nBinary representation of \$m = %s\n" .
                 "Invert %d%s bit from the end = %s\n" .
                 "And the decimal equivalent of %s = %d\n",
                   $m_bin, $n, ($n == 1 ? 'st' :
                                $n == 2 ? 'nd' :
                                $n == 3 ? 'rd' : 'th'), $s_bin, $s_bin, $s_dec;
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    my ($m, $n) = @ARGV;

    $m =~ / ^ $RE{num}{int} $ /x
                  or error( qq[\$m: "$m" is not a valid integer] );
    $m +=   0;                                    # Normalize: e.g., 010 --> 10
    $m >=   0     or error( "\$m: $m is less than 0" );
    $m <= 255     or error( "\$m: $m is greater than 255" );

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq[\$n: "$n" is not a valid integer] );
    $n +=   0;                                    # Normalize: e.g.,  08 -->  8
    $n >=   1     or error( "\$n: $n is less than 1" );
    $n <=   8     or error( "\$n: $n is greater than 8" );

    return ($m, $n);
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
