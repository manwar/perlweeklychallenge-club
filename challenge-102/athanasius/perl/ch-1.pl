#!perl

###############################################################################
=comment

Perl Weekly Challenge 102
=========================

Task #1
-------
*Rare Numbers*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

Write a script to generate all Rare numbers of size $N if exists. Please check-
out the [ http://www.shyamsundergupta.com/rare.htm |page] for more information
about it.

Examples

 (a) 2 digits: 65
 (b) 6 digits: 621770
 (c) 9 digits: 281089082

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions
-----------

1. The input, "size $N," is the number of digits in the required rare numbers.
2. Palindromic rare numbers are allowed by default (but may be filtered out by
   changing the constant $PALINDROMIC to a false value).

Implementation
--------------

The core subroutine is_rare(), which calls is_perfect_square(), is all that is
really needed. However, for values of $N above 7 or 8, the brute force approach
becomes very slow, and speed-ups are desirable. In the solution below, these
take the form of filters that reduce the number of candidates to be tested. The
filters are based on the known properties of rare numbers as detailed by Shyam
Sunder Gupta in his "Rare Numbers" webpage. (But even with the filters, $N = 9
requires around 2½ minutes of search time.)

For example, subroutine A2() generates solutions beginning with '2'; these must
also end with '2'. Suppose $N = 9. Rather than considering all 9-digit numbers,
A2() *constructs* 9-digit numbers beginning and ending with '2', thereby reduc-
ing the initial number of candidates by two orders of magnitude.

As the algorithm is slow for larger values of $N, output is displayed progress-
ively as the search proceeds, rather than all-at-once at the end.

=cut
#==============================================================================

use strict;
use warnings;
use feature        qw( state );
use Const::Fast;
use Regexp::Common qw( number );

use constant TIMER    => 1;

const my $PALINDROMIC => 1;
const my $USAGE       =>
"Usage:
  perl $0 <N>

    <N>    Positive integer: number of digits in each rare number\n";

my $rare_number_found = 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 102, Task #1: Rare Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

    my $t0 = [gettimeofday]    if TIMER;
    my $N  = parse_command_line();

    print "Input:  $N\nOutput: ";

    find_rare_numbers( $N );

    printf "%s\n", $rare_number_found ? '' : '(none)';

    my $t = tv_interval( $t0 ) if TIMER;

    print "\n$t seconds\n"     if TIMER;
}

#------------------------------------------------------------------------------
sub find_rare_numbers
#------------------------------------------------------------------------------
{
    my ($N) = @_;

    if ($N < 5)
    {
        for my $n (10 ** ($N - 1) .. 10 ** $N - 1)
        {
            record_rare_number( $n ) if is_rare( $n );
        }
    }
    else
    {
        A2   ( $N );
        A4   ( $N );
        A6   ( $N );
        A8_Q2( $N );
        A8_Q3( $N );
        A8_Q7( $N );
        A8_Q8( $N );
    }
}

#------------------------------------------------------------------------------
sub A2
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 2 then Q = 2 and B = P."

    my ($N) = @_;

    for my $bp (0 .. 9)
    {
        for my $m (0 .. 10 ** ($N - 4) - 1)
        {
            my $n = sprintf '2%d%0*d%d2', $bp, $N - 4, $m, $bp;

            record_rare_number( $n ) if is_rare( $n );
        }
    }
}

#------------------------------------------------------------------------------
sub A4
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 4 then Q = 0 and B - P = positive or negative Even digit i.e. -8,
    #  -6, -4, -2, 0, 2, 4, 6, 8."

    my ($N) = @_;

    for my $b (0 .. 9)
    {
        for my $p (0 .. 9)
        {
            next unless ($b - $p) % 2 == 0;

            for my $m (0 .. 10 ** ($N - 4) - 1)
            {
                my $n = sprintf '4%d%0*d%d0', $b, $N - 4, $m, $p;

                record_rare_number( $n ) if is_rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A6
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 6 then Q = 0 or 5 and B - P = positive or negative Odd digit i.e.
    #  -9, -7, -5, -3, -1, 1, 3, 5, 7, 9."

    my ($N) = @_;

    for my $b (0 .. 9)
    {
        for my $p (0 .. 9)
        {
            next if ($b - $p) % 2 == 0;

            for my $m (0 .. 10 ** ($N - 4) - 1)
            {
                my $n0 = sprintf '6%d%0*d%d0', $b, $N - 4, $m, $p;
                my $n5 = sprintf '6%d%0*d%d5', $b, $N - 4, $m, $p;

                record_rare_number( $n0 ) if is_rare( $n0 );
                record_rare_number( $n5 ) if is_rare( $n5 );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8_Q2
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 2 then B + P = 9"

    my ($N) = @_;

    for my $b (0 .. 9)
    {
        for my $p (0 .. 9)
        {
            next unless $b + $p == 9;

            for my $m (0 .. 10 ** ($N - 4) - 1)
            {
                my $n = sprintf '8%d%0*d%d2', $b, $N - 4, $m, $p;

                record_rare_number( $n ) if is_rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8_Q3
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 3 then B - P =  7 for B > P
    #                      and B - P = -3 for B < P
    #                      and B can never be equal to P"

    my ($N) = @_;

    for my $b (0 .. 9)
    {
        for my $p (0 .. 9)
        {
            next if $b == $p;

            if ($b > $p)
            {
                next unless $b - $p ==  7;
            }
            else
            {
                next unless $b - $p == -3;
            }

            for my $m (0 .. 10 ** ($N - 4) - 1)
            {
                my $n = sprintf '8%d%0*d%d3', $b, $N - 4, $m, $p;

                record_rare_number( $n ) if is_rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8_Q7
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 7 then B + P = 11 for B > 1
    #                      and B + P =  1 for B < 1"

    my ($N) = @_;

    for my $b (0 .. 9)
    {
        for my $p (0 .. 9)
        {
            if    ($b > 1)
            {
                next unless $b + $p == 11;
            }
            elsif ($b < 1)
            {
                next unless $b + $p ==  1;
            }

            for my $m (0 .. 10 ** ($N - 4) - 1)
            {
                my $n = sprintf '8%d%0*d%d7', $b, $N - 4, $m, $p;

                record_rare_number( $n ) if is_rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8_Q8
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 8 then B = P"

    my ($N) = @_;

    for my $bp (0 .. 9)
    {
        for my $m (0 .. 10 ** ($N - 4) - 1)
        {
            my $n = sprintf '8%d%0*d%d8', $bp, $N - 4, $m, $bp;

            record_rare_number( $n ) if is_rare( $n );
        }
    }
}

#------------------------------------------------------------------------------
sub is_rare
#------------------------------------------------------------------------------
{
    my ($number) = @_;
    my  $reverse = join '', reverse split //, $number;

    return 0 if $number < $reverse;

    return is_perfect_square( $number + $reverse ) &&
           is_perfect_square( $number - $reverse );
}

#------------------------------------------------------------------------------
# Adapted from the C++ function PerfectSquare() in
# John D. Cook, "Fast way to test whether a number is a square"
# https://www.johndcook.com/blog/2008/11/17/fast-way-to-test-whether-a-number-
# is-a-square/
#
sub is_perfect_square
#------------------------------------------------------------------------------
{
    my ($n) = @_;
    my  $h  = $n & 0xF;               # Last hexadecimal "digit"

    return 0 if $h > 9;               # Return immediately in 6 cases out of 16

    # Take advantage of Boolean short-circuit evaluation

    if ($h != 2 && $h != 3 && $h != 5 && $h != 6 && $h != 7 && $h != 8)
    {
        my $t = int( sqrt( $n ) + 0.5 );         # Take square root if you must

        return $t * $t == $n;
    }

    return 0;
}

#------------------------------------------------------------------------------
sub record_rare_number
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    if ($PALINDROMIC || !is_palindrome( $n ))
    {
        if (state $first = 1)
        {
            print $n;
            $first = 0;
        }
        else
        {
            print ", $n";
        }

        $rare_number_found = 1;
    }
}

#------------------------------------------------------------------------------
sub is_palindrome
#------------------------------------------------------------------------------
{
    my ($n)     = @_;
    my  @digits = split //, $n;

    for my $i (0 .. int($#digits / 2))
    {
        return 0 unless $digits[ $i ] == $digits[ $#digits - $i ];
    }

    return 1;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command-line argument, found $args" );

    my $N =  $ARGV[0];
       $N =~ / ^ $RE{num}{int} $ /x && $N > 0
                  or error( qq["$N" is not a positive integer] );

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
