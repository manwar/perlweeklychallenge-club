#!perl

###############################################################################
=comment

Perl Weekly Challenge 134
=========================

TASK #1
-------
*Pandigital Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 5 Pandigital Numbers in base 10.

As per the [ https://en.wikipedia.org/wiki/Pandigital_number |wikipedia], it
says:

    A pandigital number is an integer that in a given base has among its
    significant digits each digit used in the base at least once.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Is zero a "significant" digit?
- if so,  then the base-10            pandigital numbers begin with 1023456789;
- if not, then the base-10 "zeroless" pandigital numbers begin with  123456789.

Since the definition is not specified in the Task description, the solution
below accommodates both definitions. For zeroless pandigitals the script must
be invoked with a --zeroless flag. If no flag is given, the script defaults to
pandigital numbers in which the zero digit is included.

Algorithm
---------
Permutations of the digits are generated in ascending numerical order.

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Loops qw( NextPermuteNum );
use Const::Fast;
use Getopt::Long;

const my $TARGET => 5;
const my $USAGE  => "Usage:\n  perl $0 [--zeroless]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 134, Task #1: Pandigital Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $zeroless = parse_command_line();

    printf 'The first %d pandigital numbers in base 10 containing the ' .
           "digits %d-9%s:\n\n", $TARGET,
                                 $zeroless ? (1, ' (zeroless)') : (0, '');

    my $count  = 0;
    my @digits = $zeroless ? 1 .. 9 : 0 .. 9;

    # For an explanation of the arcane syntax below, see:
    #     https://perldoc.perl.org/perlsyn#Statement-Modifiers

    LOOP:
    {
        do
        {{
            next if $digits[ 0 ] == 0;

            printf "    %s\n", join '', @digits;

            last LOOP if ++$count >= $TARGET;

        }} while NextPermuteNum( @digits );
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $zeroless;

    GetOptions( zeroless  => \$zeroless )
            or error( 'Invalid command line argument' );

    my $args = scalar @ARGV;
       $args == 0
            or error( "Expected 0 command line arguments, found $args" );

    return $zeroless;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
