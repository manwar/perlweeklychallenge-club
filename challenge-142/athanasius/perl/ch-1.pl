#!perl

###############################################################################
=comment

Perl Weekly Challenge 142
=========================

TASK #1
-------
*Divisor Last Digit*

Submitted by: Mohammad S Anwar

You are given positive integers, $m and $n.

Write a script to find total count of divisors of $m having last digit $n.

Example 1:

 Input: $m = 24, $n = 2
 Output: 2

 The divisors of 24 are 1, 2, 3, 4, 6, 8 and 12.
 There are only 2 divisors having last digit 2 are 2 and 12.

Example 2:

 Input: $m = 30, $n = 5
 Output: 2

 The divisors of 30 are 1, 2, 3, 5, 6, 10 and 15.
 There are only 2 divisors having last digit 5 are 5 and 15.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
1. $INCLUDE_M
   The "divisors" of $m usually include both 1 and $m itself. However, in the
   two examples given in the task description, $m is omitted from the list of
   divisors. The constant $INCLUDE_M (false by default) may be set to a true
   value to ensure that $m will be included in the output if it is divisible by
   $n.
2. $VERBOSE
   When this is set to a true value (the default), the output will be followed
   by an explanation similar to the explanations shown in the Examples. This
   explanation will be omitted if $VERBOSE is set to a false value.

Algorithm
---------
The subroutine find_divisors() is copied from the solution to Task 1 in Week
141:

    1. Divisors come in pairs: if i is a divisor of n then j = n / i is also a
       divisor of n
    2. If i = j then i = sqrt(n)

    So, to find all the divisors of n by searching, it's only necessary to
    search the range 1 to sqrt(n):

        divisors := empty
        FOR d in range 1 to ⌊sqrt(n)⌋
            IF d is a divisor of n THEN
                Add d to divisors
                d1 := n / d
                IF d < d1
                    Add d1 to divisors
                ENDIF
            ENDIF
        ENDFOR
        sort divisors ascending

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $INCLUDE_M => 0;
const my $VERBOSE   => 1;
const my $USAGE     =>
"Usage:
  perl $0 <m> <n>

    <m>    A positive integer
    <n>    A decimal digit (0-9)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 142, Task #1: Divisor Last Digit (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($m, $n) = parse_command_line();

    print "Input:  \$m = $m, \$n = $n\n";

    my  @divisors = find_divisors( $m );

    pop @divisors unless $INCLUDE_M;

    my  @solution = grep { / $n $ /x } @divisors;
    my  $count    = scalar @solution;

    print "Output: $count\n";

    if ($VERBOSE)
    {
        printf "\nThe divisors of %d are %s\n",
            $m,
            join ', ', @divisors;

        printf "Of these, %d ha%s %d as %s last digit%s\n",
            $count,
            $count == 1 ? 's'   : 've',
            $n,
            $count == 1 ? 'its' : 'their',
            $count == 0 ? ''    : ': ' . join ', ', @solution;
    }
}

#------------------------------------------------------------------------------
sub find_divisors
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  @div;

    for my $d (1 .. int sqrt $n)
    {
        if ($n % $d == 0)
        {
            push @div, $d;

            my $d1 = $n / $d;

            push @div, $d1 if $d < $d1;
        }
    }

    return sort { $a <=> $b } @div;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 2 or error( "Expected 2 command line arguments, found $args" );

    my ($m, $n) = @ARGV;

    $m =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$m" is not a valid integer] );

    $m > 0        or error( qq["$m" is not positive] );

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    0 <= $n <= 9  or error( qq["$n" is not a digit] );

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
