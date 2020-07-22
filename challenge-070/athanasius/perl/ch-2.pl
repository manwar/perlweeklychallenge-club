#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my @ONE_BIT_SEQ => (0, 1);
const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    Number of bits: integer >= 2 and <= 5\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 070, Task #2: Gray Code Sequence (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $N = parse_command_line();

    print  "Input:  \$N = $N\n\n";

    # For the conversion from binary to decimal, see perlfaq4:
    # "How do I convert between numeric representations/bases/radixes?"

    my @gray_codes = map { oct "0b$_" } gray_codes_binary($N);

    printf "Output: [%s]\n", join(', ', @gray_codes);
}

#-------------------------------------------------------------------------------
sub gray_codes_binary
#-------------------------------------------------------------------------------
{
    my ($N) = @_;
        $N >= 1                    or die "ERROR: Invalid argument $N, stopped";

    return @ONE_BIT_SEQ if $N == 1;             # Base case

    my @seq = gray_codes_binary($N - 1);        # Recursive call
    my @s1  = map { "0$_" }         @seq;
    my @s2  = map { "1$_" } reverse @seq;

    return (@s1, @s2);                          # Concatenate the arrays
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV == 1                                             or die $USAGE;

    my ($N) = @ARGV;
        $N  =~ m[ \A $RE{num}{int} \z ]x && $N >= 2 && $N <= 5    or die $USAGE;

    return $N;
}

################################################################################
