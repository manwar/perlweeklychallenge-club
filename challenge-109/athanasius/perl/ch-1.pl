#!perl

###############################################################################
=comment

Perl Weekly Challenge 109
=========================

TASK #1
-------
*Chowla Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Chowla Numbers, named after, *Sarvadaman D.
S. Chowla*, a London born Indian American mathematician. It is defined as:

[ C(n) = (sum of divisors of n) - 1 - n ]
  C(n) =  sum of divisors of n except 1 and n

NOTE: Updated the above definition as suggested by Abigail [2021/04/19 18:40].

Output:

 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Although the Task requires the first 20 Chowla Numbers, an option is provided
for the user to specify the number of Chowla Numbers to be generated and dis-
played.

Algorithm
---------
From OEIS "A048050. Chowla's function: sum of divisors of n except 1 and n." :-
"a(n) = 0 if and only if n is a noncomposite number (Cf. A008578). - Omar E.
 Pol, Jul 31 2012"

The algorithm employed is a straightforward calculation:
(1) If n = 1 or n is prime, a(n) = 0
(2) Else a(n) = sum of divisors of n except 1 and n

Implementation
--------------
The CPAN module Math::Prime::Util provides the divisors() function which
returns "a uniqued sorted list" of the divisors of a given positive integer.
That module's is_prime() function is also used to screen out zero-valued Chowla
Numbers.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( divisors is_prime );
use Regexp::Common    qw( number );

const my $TARGET => 20;
const my $USAGE  =>
"Usage:
  perl $0 [<target>]

    [<target>]    How many Chowla numbers are to be generated?\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 109, Task #1: Chowla Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $target = parse_command_line();

    print "Input:  $target\n";
    print 'Output: ', chowla( 1  );
    print ', ',       chowla( $_ ) for 2 .. $target;
    print "\n";
}

#------------------------------------------------------------------------------
sub chowla
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    return 0 if $n == 1 || is_prime( $n );

    my @divisors = divisors( $n );

    my $sum  = 0;
       $sum += $divisors[ $_ ] for 1 .. $#divisors - 1;         # Omit 1 and $n

    return $sum;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;

    0 <= $args <= 1
        or error( "Expected 0 or 1 command line arguments, found $args" );

    my $target = ($args == 1) ? $ARGV[0] : $TARGET;

    $target =~ / ^ $RE{num}{int} $ /x
        or error( qq["$target" is not an integer] );

    $target > 0
        or error( 'The target must be greater than zero' );

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
