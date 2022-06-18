#!perl

###############################################################################
=comment

Perl Weekly Challenge 168
=========================

TASK #2
-------
*Home Prime*

Submitted by: Mohammad S Anwar

You are given an integer greater than 1.

Write a script to find the home prime of the given number.

In number theory, the home prime HP(n) of an integer n greater than 1 is the
prime number obtained by repeatedly factoring the increasing concatenation of
prime factors including repetitions.

Further information can be found on [ https://en.wikipedia.org/wiki/Home_prime
|Wikipedia] and [ https://oeis.org/A037274 |OEIS].

Example

As given in the Wikipedia page,

  HP(10) = 773, as
   10 factors as 2×5 yielding HP10(1)                                =  25,
   25 factors as 5×5 yielding HP10(2) = HP25(1)                      =  55,
   55          = 5×11 implies HP10(3) = HP25(2) = HP55(1)            = 511, and
  511          = 7×73 gives   HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773,
                                                                a prime number.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If the constant $VERBOSE is set to a true value (the default), all the steps in
the calculation of a home prime are given as they are performed. For example,
for input 10 the trajectory (set of steps) is:

    Trajectory: 10 -> 2|5 -> 5|5 -> 5|11 -> 7|73

which shows that 10 has prime factors 2 and 5; 25 has prime factors 5 and 5; 55
has prime factors 5 and 11; and 511 has prime factors 7 and 73; producing 773,
which is prime.

If the constant $TIMER is set to a true value (it is false by default), the
time, in seconds, required to find the requested home prime is also displayed.

Implementation
--------------
Factorization and primality testing are performed by the CPAN module Math::
Prime::Util::GMP, which uses the GNU Multiple Precision Arithmetic Library
(GMP). GMP employs "[h]ighly optimized assembly language code for the most
important inner loops, specialized for different processors." [1] This results
in very efficient (and therefore very fast) processing for large numbers.

Performance
-----------
HP(2) to HP(48) are each calculated in 0.02 seconds or less. (Note: the value
of HP(49) = HP(77) is not currently known.)

Reference
---------
[1] "GNU Multiple Precision Arithmetic Library", Wikipedia,
     https://en.wikipedia.org/wiki/GNU_Multiple_Precision_Arithmetic_Library

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util::GMP qw( factor is_prime );
use Regexp::Common;

use constant TIMER => 0;

const my $VERBOSE  => 1;
const my $USAGE    =>
"Usage:
  perl $0 <n>

    <n>    An integer greater than 1\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 168, Task #2: Home Prime (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

    my $t0  = [gettimeofday]    if TIMER;
    my $n   = parse_command_line();
    my $hp  = $n;

    unless (is_prime $hp)
    {
        print "Trajectory: $n"  if $VERBOSE;

        until (is_prime $hp)
        {
            my @prime_factors = factor $hp;

               $hp     = join '',  @prime_factors;
            my $hp_str = join '|', @prime_factors;

            print " -> $hp_str" if $VERBOSE;
        }

        print "\n\n"            if $VERBOSE;
    }

    print "HP($n) = $hp\n";

    my $t   = tv_interval($t0)  if TIMER;
    print  "\n$t seconds\n"     if TIMER;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n > 1        or error( qq["$n" is not greater than one] );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
