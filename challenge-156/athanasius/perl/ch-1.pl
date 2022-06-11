#!perl

###############################################################################
=comment

Perl Weekly Challenge 156
=========================

TASK #1
-------
*Pernicious Numbers*

Submitted by: Mohammad S Anwar

Write a script to permute first 10 Pernicious Numbers.

    A pernicious number is a positive integer which has prime number of ones in
    its binary representation.

The first pernicious number is 3 since binary representation of 3 = (11) and
1 + 1 = 2, which is a prime.

Expected Output

  3, 5, 6, 7, 9, 10, 11, 12, 13, 14

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Although the Task specifies a target of 10, I have extended the solution to
accept any target integer value greater than 0; but if no argument is supplied
on the command line, the target defaults to 10.

Table
-----
The first 100 Pernicious Numbers [1, 2]:

      3,   5,   6,   7,   9,  10,  11,  12,  13,  14,
     17,  18,  19,  20,  21,  22,  24,  25,  26,  28,
     31,  33,  34,  35,  36,  37,  38,  40,  41,  42,
     44,  47,  48,  49,  50,  52,  55,  56,  59,  61,
     62,  65,  66,  67,  68,  69,  70,  72,  73,  74,
     76,  79,  80,  81,  82,  84,  87,  88,  91,  93,
     94,  96,  97,  98, 100, 103, 104, 107, 109, 110,
    112, 115, 117, 118, 121, 122, 124, 127, 129, 130,
    131, 132, 133, 134, 136, 137, 138, 140, 143, 144,
    145, 146, 148, 151, 152, 155, 157, 158, 160, 161

Algorithm
---------
The natural numbers, in ascending order, are filtered as follows:
 - each natural number n is converted to its binary representation b;
 - the 1-digits in b are counted;
 - if the count is a primary number, n is recorded as a pernicious number;
 - the filtering process continues until the number of pernicious numbers found
   is equal to the given target.

References
----------
[1] "A052294  Pernicious numbers: numbers with a prime number of 1's in their
     binary expansion.", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A052294
[2]  Iain Fox, "Table of n, a(n) for n = 1..10000",
     https://oeis.org/A052294/b052294.txt
[3] "Pernicious number", Wikipedia,
     https://en.wikipedia.org/wiki/Pernicious_number

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use ntheory        qw( is_prime );
use Regexp::Common qw( number );

const my $TARGET => 10;
const my $USAGE  =>
"Usage:
  perl $0 [<target>]

    [<target>]    The required output size [default: $TARGET]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 156, Task #1: Pernicious Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $target = parse_command_line();

    print "The first $target Pernicious Numbers:\n";

    my @pernicious;

    for (my $n = 1; scalar @pernicious < $target; ++$n)
    {
        my $bin  = sprintf '%b', $n;            # Convert to binary
        my $ones = $bin =~ tr/1//;              # Count the ones

        push @pernicious, $n if is_prime( $ones );
    }

    printf "%s\n", join ', ', @pernicious;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my   $args = scalar @ARGV;
    0 <= $args <= 1 or error( 'Expected no more than 1 command line ' .
                              "argument, found $args" );

    my $target = $args == 0 ? $TARGET : $ARGV[ 0 ];

       $target =~ / ^ $RE{num}{int} $ /x
                    or error( qq["$target" is not a valid integer] );

       $target > 0  or error( 'Target must be greater than 0' );

    return $target;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
