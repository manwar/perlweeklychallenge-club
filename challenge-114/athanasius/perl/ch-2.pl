#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Output
------
With DEBUG set to True, the output includes the binary forms of N and the
solution S, together with a count of their 1-bits. If this extra information is
not wanted, set DEBUG to False and the output will show N and S only.

Algorithm
---------
0. Input N
1. Convert N to its binary form, N_bin
     Let d be the number of   digits in N_bin
     Let n be the number of 1-digits in N_bin
2. IF
     Any 0-digit (in position z within N_bin) lies between 1-digits,
   THEN
     S_bin is constructed as follows:
       2.1 the digits above z in N_bin remain unchanged
       2.2 the digit at z becomes 1
       2.3 the remaining complement (n - 2) of 1-digits occupy the least
           significant places in S_bin
       2.4 any remaining digits between z and the group of least significant
           1-digits are set to zero, bringing S_bin up to a total of d digits
3. ELSE
     S_bin is constructed as follows:
       3.1 an initial 1-digit
       3.2 the remaining complement (n - 1) of 1-digits in the least
           significant places
       3.3 0-digits for padding, bringing S_bin up to a total of (d + 1) digits
   ENDIF
4. Convert S_bin to its decimal form, S
5. Output S

(Note that a brute force approach -- set S to N + 1 and continue to increment S
until the number of 1-digits in S_bin equals d -- works well for smaller values
of N and for certain larger values, but becomes unacceptably slow for large
values of N where N is a power of 2.)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

use constant DEBUG => 1;

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    A non-zero, positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 114, Task #2: Higher Integer Set Bits (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N      = parse_command_line();

    print "Input: \$N = $N\n" unless DEBUG;

    my $N_bin  = sprintf '%b', $N;
    my $N_ones = $N_bin =~ tr/1//;
    my $S_bin  = solve( $N, $N_bin, $N_ones );
    my $S      = oct( '0b' . $S_bin );

    if (DEBUG)
    {
        printf "Input: \$N = %*d (%d one-bit%s: %*b)\n",
                length( $S ), $N, $N_ones, ($N_ones == 1 ? '' : 's'),
                length( $S_bin ), $N;

        my $S_bits = $S_bin =~ tr/1//;

        printf "Output:     %d (%d one-bit%s: %s)\n",
                $S, $S_bits, ($S_bits == 1 ? '' : 's'), $S_bin;
    }
    else
    {
        print  "Output:     $S\n";
    }
}

#------------------------------------------------------------------------------
sub solve
#------------------------------------------------------------------------------
{
    my ($N, $N_bin, $N_ones) = @_;
    my  @N_digits = split //, $N_bin;
    my  $found_1  =  0;
    my  $S_bin    = '1';
    my  $zero_i;

    for my $i (reverse 1 .. $#N_digits)
    {
        if ($found_1)
        {
            $zero_i  = $i, last if $N_digits[ $i ] == 0;
        }
        else
        {
            $found_1 = 1        if $N_digits[ $i ] == 1;
        }
    }

    if (defined $zero_i)
    {
        $S_bin .= substr $N_bin, 1, $zero_i - 1;
        $S_bin .= '1';

        my $ones_diff = $N_ones - $S_bin =~ tr/1//;

        $S_bin .= '0' x (length( $N_bin ) - length( $S_bin ) - $ones_diff);
        $S_bin .= '1' x  $ones_diff;
    }
    else
    {
        $S_bin .= '0' x (length( $N_bin ) - $N_ones + 1);
        $S_bin .= '1' x ($N_ones - 1);
    }

    return $S_bin;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1
              or error( "Expected 1 command line argument, found $args" );

    my $N = $ARGV[ 0 ];
       $N =~ / ^ $RE{num}{int} $ /x
              or error( qq["$N" is not a valid integer]   );
       $N > 0 or error( qq["$N" is not greater than zero] );

    return $N + 0;                                                  # Normalize
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
