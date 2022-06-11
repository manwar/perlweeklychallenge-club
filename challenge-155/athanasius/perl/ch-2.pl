#!perl

###############################################################################
=comment

Perl Weekly Challenge 155
=========================

TASK #2
-------
*Pisano Period*

Submitted by: Mohammad S Anwar

Write a script to find the period of the 3rd Pisano Period.

    In number theory, the nth Pisano period, written as π(n), is the period
    with which the sequence of Fibonacci numbers taken modulo n repeats.

The Fibonacci numbers are the numbers in the integer sequence:

 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584,
 4181, 6765, ...

For any integer n, the sequence of Fibonacci numbers F(i) taken modulo n is
periodic. The Pisano period, denoted π(n), is the value of the period of this
sequence. For example, the sequence of Fibonacci numbers modulo 3 begins:

 0, 1, 1, 2, 0, 2, 2, 1,
 0, 1, 1, 2, 0, 2, 2, 1,
 0, 1, 1, 2, 0, 2, 2, 1, ...

This sequence has period 8, so π(3) = 8.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Although the Task specifies n = 3, I have extended the solution to accept any
target integer value of n greater than 0. (If no argument is supplied on the
command line, the target n defaults to 3.)

If the constant $VERBOSE is set to a true value (the default), the required
period is followed by the contents of each cycle. Following the example of the
"Tables" section in [3], cycles are displayed with spaces before zeros and with
numbers greater than 9 represented by alphabetic characters. For example, for
n = 13:

    The 13th Pisano Period is 28, with cycle: 0112358 0883B1C 0CCBA85 055A2C1

Known Facts
-----------
(1) The Pisano period π(n) is always even for values of n > 2 [3]
(2) The maximum value of π(n) is 6n [1, 3]

Algorithm
---------
1.  Generate the first 12n Fibonacci numbers (this is the minimum needed to
    ensure that the largest possible period, 6n, will be tested for at least 1
    whole cycle in Step 3)
2.  Derive @mods, the first 12n Fibonacci numbers modulo n
3.  Search for the smallest period p for which each element in its first cycle
    in @mods matches that element's corresponding elements in all subsequent
    cycles in @mods. For example, if n = 3, then @mods =
    0 1 1 2 0 2 2 1 0 1 1 2 0 2 2 1 0 1 1 2 0 2 2 1 0 1 1 2 0 2 2 1 0 1 1 2
    and the search proceeds as follows:
    for p = 1, $mods[0] != $mods[ 1];
    for p = 2, $mods[0] != $mods[ 2];
    for p = 3, $mods[0] != $mods[ 3];
    for p = 4, $mods[0] == $mods[ 4] but $mods[1] != $mods[5];
    for p = 5, $mods[0] != $mods[ 5];
    for p = 6, $mods[0] != $mods[ 6];
    for p = 7, $mods[0] != $mods[ 7];
    for p = 8, $mods[0] == $mods[ 8] == $mods[16] == $mods[24] == $mods[32],
               $mods[1] == $mods[ 9] == $mods[17] == $mods[25] == $mods[33],
               $mods[2] == $mods[10] == $mods[18] == $mods[26] == $mods[34],
               and so on to
               $mods[7] == $mods[15] == $mods[23] == $mods[31]
    Therefore, the search finds π(n) = 8
4.  Output the period and, optionally, its corresponding cycle

References
----------
[1]  K. S. Brown (2017), "Periods of Fibonacci Sequences Mod m",
     https://oeis.org/A001175/a001175_1.pdf
[2] "A001175  Pisano periods (or Pisano numbers): period of Fibonacci numbers
     mod n.", The On-Line Encyclopedia of Integer Sequences,
     https://oeis.org/A001175
[3] "Pisano period", Wikipedia, https://en.wikipedia.org/wiki/Pisano_period

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::BigInt;
use Regexp::Common qw( number );

const my $TARGET  =>  3;
const my $VERBOSE =>  1;
const my @DIGITS  => (0 .. 9, 'A' .. 'Z', 'a' .. 'z');
const my $MAX_LEN => 30;
const my $USAGE   =>
"Usage:
  perl $0 [<n>]

    [<n>]    Integer > 0: The required Pisano Period [default: $TARGET]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 155, Task #2: Pisano Period (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $n       = parse_command_line();
    my $max_p   = 6 * $n;
    my $fibs    = get_fibonacci_numbers( 2 * $max_p );
    my @mods    = map { ($_ % $n)->numify() } @$fibs;
    my $period  = 0;
    my $step    = $n <= 2 ? 1 : 2;

    PERIOD:
    for (my $p = $step; $p <= $max_p; $p += $step)
    {
        for my $i (0 .. $max_p - 1)
        {
            my $f = $mods[ $i ];

            for (my $j = $i + $p; $j <= $#mods; $j += $p)
            {
                next PERIOD unless $mods[ $j ] == $f;
            }
        }

        $period = $p;
        last PERIOD;
    }

    $period > 0 or die "No period found for n = $n, stopped";

    printf "The %d%s Pisano Period is %d", $n, ordinal( $n ), $period;
    printf ", with cycle: %s", get_cycle( \@mods, $period )
                                           if $VERBOSE && $n <= scalar @DIGITS;
    print  "\n";
}

#------------------------------------------------------------------------------
sub get_fibonacci_numbers
#------------------------------------------------------------------------------
{
    my ($count) =  @_;
    my  $f0     =  Math::BigInt->new( 0 );
    my  $f1     =  Math::BigInt->new( 1 );
    my  @fibs   = ($f0, $f1);

    while (scalar @fibs < $count)
    {
        my $f2 = $f0 + $f1;

        push @fibs, $f2;

        ($f0, $f1) = ($f1, $f2);
    }

    return [ @fibs[ 0 .. $count - 1 ] ];
}

#------------------------------------------------------------------------------
sub get_cycle
#------------------------------------------------------------------------------
{
    my ($mods, $period) = @_;
    my  $cycle;
        $cycle .= $DIGITS[ $_ ] for @$mods[ 0 .. $period - 1 ];

    if ($period <= $MAX_LEN)
    {
        $cycle =~ s/ (.)(?=0) /$1 /gx;
    }
    else
    {
        $cycle =~ s/ (.)(?=0) /$1\n/gx;
        $cycle =  "\n" . $cycle; 
    }

    return $cycle;
}

#------------------------------------------------------------------------------
sub ordinal
#------------------------------------------------------------------------------
{
    my ($n)   =  @_;
    my  $ord  = 'th';
    my  $tens = ($n / 10) % 10;              # "Tens" digit (or 0 if $n < 10)

    if ($tens != 1)
    {
        my $lsd = $n % 10;                   # Least significant ("ones") digit

        $ord = $lsd == 1 ? 'st' :
               $lsd == 2 ? 'nd' :
               $lsd == 3 ? 'rd' : 'th';
    }

    return $ord;
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
