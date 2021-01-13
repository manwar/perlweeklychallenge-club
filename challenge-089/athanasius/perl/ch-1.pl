#!perl

###############################################################################
=comment

Perl Weekly Challenge 089
=========================

Task #1
-------
*GCD Sum*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to sum [ https://en.wikipedia.org/wiki/Greatest_common_divisor |
GCD] of all possible unique pairs between 1 and $N.

Example 1:

 Input: 3
 Output: 3

 gcd(1,2) + gcd(1,3) + gcd(2,3)

Example 2:

 Input: 4
 Output: 7

 gcd(1,2) + gcd(1,3) + gcd(1,4) + gcd(2,3) + gcd(2,4) + gcd(3,4)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

From the Examples, it appears that "all possible unique pairs between 1 and $N"
should be interpreted to mean:

    all (i, j) such that 1 <= i < j <= N.

In the solution below, the GCD calculation is performed by the gcd() function
in the CPAN module Math::Prime::Util.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( gcd );
use Regexp::Common    qw( number );

const my $USAGE =>
"Usage:
  perl $0 <N>

    <N>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 089, Task #1: GCD Sum (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $N = parse_command_line();

    print "Input:  $N\n";

    my $sum = 0;

    for my $i (1 .. $N - 1)
    {
        for my $j ($i + 1 .. $N)
        {
            $sum += gcd($i, $j);
        }
    }

    print "Output: $sum\n";
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 0                 and error('Command-line argument missing'  );
       $args >  1                 and error('Too many command-line arguments');

    my $N =  $ARGV[0];
       $N =~ /\A$RE{num}{int}\z/  or  error( qq["$N" is not an integer] );
       $N >  0                    or  error( qq["$N" is not positive]   );

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
