#!perl

###############################################################################
=comment

Perl Weekly Challenge 155
=========================

TASK #1
-------
*Fortunate Numbers*

Submitted by: Mohammad S Anwar

Write a script to produce first 8 Fortunate Numbers (unique and sorted).

According to [ https://en.wikipedia.org/wiki/Fortunate_number |Wikipedia]

    A Fortunate number, named after Reo Fortune, is the smallest integer m > 1
    such that, for a given positive integer n, pn# + m is a prime number, where
    the primorial pn# is the product of the first n prime numbers.

Expected Output

 3, 5, 7, 13, 17, 19, 23, 37

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Although the Task specifies n = 8, I have extended the solution to accept any
target integer value of n greater than 1. (If no argument is supplied on the
command line, the target n defaults to 8.)

Algorithm
---------
Generating Fortunate numbers is straightforward: given successive primes, gen-
erate successive primorials, and for each new primorial pn# search for the
smallest m > 1 which satisfies the condition: (pn# + m) is prime. Discard
duplicates as they are found.

However, because solutions are generated out-of-order, the problem is to know
how many Fortunate numbers to produce to be sure that none are missing from the
solution. For example, when n = 9, the solution is:

    3, 5, 7, 13, 17, 19, 23, 37, 47

but the first 12 Fortunate numbers generated are

    3, 5, 7, 13, 23, 17, 19, 37, 61, 67, 71, 47

showing that the 9th element in the solution is found only *after* the larger
Fortunate numbers 61, 67, and 71 have been generated.

The answer to this problem arises from the following observation: a primorial
pn# = 2 x 3 x 5 x ... x pn, from which it follows that:

  - pn# + 2 is divisible by 2, and so not prime;
  - pn# + 3 is divisible by 3, and so not prime;
  - and so on up to pn;
  - moreover, pn# + c, where c is a composite number with all prime factors in
    the set { 2, 3, ... pn }, will also be divisible by c's prime factors and
    so not prime.

Also, p#n + 1 may be prime, but is excluded because it is required that m > 1.
Hence, the smallest possible value of m is pn + 1.

Let m_max be the nth entry in the sorted list of unique Fortunate numbers found
so far. As the search proceeds, the value of pn increases. When pn becomes as
large as m_max, it is impossible for the next value of m to be less than m_max,
so the search can safely end.

References
----------
[1] "A046066  Fortunate primes (A005235) in numerical order with duplicates
     removed", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A046066
[2] "A082115  Fibonacci sequence (mod 3).", The On-Line Encyclopedia of Integer
     Sequences, https://oeis.org/A082115
[3] "Primorial", Wikipedia, https://en.wikipedia.org/wiki/Primorial

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util        qw( none );
use Math::BigInt;
use Math::Prime::Util qw( is_prime next_prime );
use Regexp::Common    qw( number );

const my $TARGET => 8;
const my $USAGE  =>
"Usage:
  perl $0 [<target>]

    [<target>]    Integer > 1: Required number of output values " .
                                                        "[default: $TARGET]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 155, Task #1: Fortunate Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $target     =  parse_command_line();
    my $prime      =  2;
    my $primorial  =  Math::BigInt->new( $prime );
    my @fortunates = (3);
    my $count      =  0;

    until ($count >= $target && $prime >= $fortunates[ $target - 1 ])
    {
        $prime      = next_prime( $prime );
        $primorial *= $prime;

        my $m  = $prime + 2;
           $m += 2 until is_prime( $primorial + $m );

        if (none { $m == $_ } @fortunates)                 # Discard duplicates
        {
            ++$count;
            push @fortunates, $m;
            @fortunates = sort { $a <=> $b } @fortunates;  # Keep sorted
        }
    }

    printf "The first $target Fortunate Numbers (unique and sorted):\n%s\n",
            join ', ', @fortunates[ 0 .. $target - 1 ];
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my   $args = scalar @ARGV;
    0 <= $args <= 1 or error( 'Expected no more than 1 command line ' .
                              "argument, found $args" );

    my $target = scalar @ARGV == 0 ? $TARGET : $ARGV[ 0 ];

       $target =~ / ^ $RE{num}{int} $ /x
                    or error( qq["$target" is not a valid integer] );

       $target > 1  or error( 'Target must be greater than 1' );

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
