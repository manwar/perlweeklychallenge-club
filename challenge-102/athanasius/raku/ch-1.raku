use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Assumptions
-----------

1. The input, "size $N," is the number of digits in the required rare numbers.
2. Palindromic rare numbers are allowed by default (but may be filtered out by
   changing the constant $PALINDROMIC to False).

Implementation
--------------

The core subroutine is-rare(), which calls is-perfect-square(), is all that is
really needed. However, for values of $N above 6, the brute force approach
becomes very slow, and speed-ups are desirable. In the solution below, these
take the form of filters that reduce the number of candidates to be tested. The
filters are based on the known properties of rare numbers as detailed by Shyam
Sunder Gupta in his "Rare Numbers" webpage. (But even with the filters, $N = 7
requires more than 2½ minutes of search time.)

For example, subroutine A2() generates solutions beginning with '2'; these must
also end with '2'. Suppose $N = 9. Rather than considering all 9-digit numbers,
A2() *constructs* 9-digit numbers beginning and ending with '2', thereby reduc-
ing the initial number of candidates by two orders of magnitude.

As the algorithm is slow for larger values of $N, output is displayed progress-
ively as the search proceeds, rather than all-at-once at the end.

=end comment
#==============================================================================

my Bool constant $PALINDROMIC = True;

my Bool $rare-number-found    = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 102, Task #1: Rare Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D $N where { $N > 0 }          #= Positive integer:
                                        #= number of digits in each rare number
)
#==============================================================================
{
    my Instant $t0 = now;

    "Input:  $N\nOutput: ".print;

    find-rare-numbers( $N );

    "%s\n".printf: $rare-number-found ?? '' !! '(none)';

    my Instant $t = now;

    "\n{ $t - $t0 } seconds".put;
}

#------------------------------------------------------------------------------
sub find-rare-numbers( UInt:D $N )
#------------------------------------------------------------------------------
{
    if $N < 5
    {
        for 10 ** ($N - 1) .. 10 ** $N - 1 -> UInt $n
        {
            record-rare-number( $n ) if is-rare( $n );
        }
    }
    else
    {
        A2\  ( $N );
        A4\  ( $N );
        A6\  ( $N );
        A8-Q2( $N );
        A8-Q3( $N );
        A8-Q7( $N );
        A8-Q8( $N );
    }
}

#------------------------------------------------------------------------------
sub A2( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 2 then Q = 2 and B = P."

    for 0 .. 9 -> UInt $bp
    {
        for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
        {
            my UInt $n = '2%d%0*d%d2'.sprintf( $bp, $N - 4, $m, $bp ).Int;

            record-rare-number( $n ) if is-rare( $n );
        }
    }
}

#------------------------------------------------------------------------------
sub A4( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 4 then Q = 0 and B - P = positive or negative Even digit i.e. -8,
    #  -6, -4, -2, 0, 2, 4, 6, 8."

    for 0 .. 9 -> UInt $b
    {
        for 0 .. 9 -> UInt $p
        {
            next unless ($b - $p) % 2 == 0;

            for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
            {
                my UInt $n = '4%d%0*d%d0'.sprintf( $b, $N - 4, $m, $p ).Int;

                record-rare-number( $n ) if is-rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A6( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 6 then Q = 0 or 5 and B - P = positive or negative Odd digit i.e.
    #  -9, -7, -5, -3, -1, 1, 3, 5, 7, 9."

    for 0 .. 9 -> UInt $b
    {
        for 0 .. 9 -> UInt $p
        {
            next if ($b - $p) % 2 == 0;

            for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
            {
                my UInt $n0 = '6%d%0*d%d0'.sprintf( $b, $N - 4, $m, $p ).Int;
                my UInt $n5 = '6%d%0*d%d5'.sprintf( $b, $N - 4, $m, $p ).Int;

                record-rare-number( $n0 ) if is-rare( $n0 );
                record-rare-number( $n5 ) if is-rare( $n5 );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8-Q2( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 2 then B + P = 9"

    for 0 .. 9 -> UInt $b
    {
        for 0 .. 9 -> UInt $p
        {
            next unless $b + $p == 9;

            for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
            {
                my UInt $n = '8%d%0*d%d2'.sprintf( $b, $N - 4, $m, $p ).Int;

                record-rare-number( $n ) if is-rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8-Q3( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 3 then B - P =  7 for B > P
    #                      and B - P = -3 for B < P
    #                      and B can never be equal to P"

    for 0 .. 9 -> UInt $b
    {
        for 0 .. 9 -> UInt $p
        {
            next if $b == $p;

            if $b > $p
            {
                next unless $b - $p ==  7;
            }
            else
            {
                next unless $b - $p == -3;
            }

            for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
            {
                my UInt $n = '8%d%0*d%d3'.sprintf( $b, $N - 4, $m, $p ).Int;

                record-rare-number( $n ) if is-rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8-Q7( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 7 then B + P = 11 for B > 1
    #                      and B + P =  1 for B < 1"

    for 0 .. 9 -> UInt $b
    {
        for 0 .. 9 -> UInt $p
        {
            if    $b > 1
            {
                next unless $b + $p == 11;
            }
            elsif $b < 1
            {
                next unless $b + $p ==  1;
            }

            for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
            {
                my UInt $n = '8%d%0*d%d7'.sprintf( $b, $N - 4, $m, $p ).Int;

                record-rare-number( $n ) if is-rare( $n );
            }
        }
    }
}

#------------------------------------------------------------------------------
sub A8-Q8( UInt:D $N )
#------------------------------------------------------------------------------
{
    # "Consider a Rare number ABCD...MNPQ with any number of digits, then ...
    #  If A = 8 and Q = 8 then B = P"

    for 0 .. 9 -> UInt $bp
    {
        for 0 .. 10 ** ($N - 4) - 1 -> UInt $m
        {
            my UInt $n = '8%d%0*d%d8'.sprintf( $bp, $N - 4, $m, $bp ).Int;

            record-rare-number( $n ) if is-rare( $n );
        }
    }
}

#------------------------------------------------------------------------------
sub is-rare( UInt:D $number --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt $reverse = $number.split( '' ).reverse.join( '' ).Int;

    return False if $number < $reverse;

    return is-perfect-square( $number + $reverse ) &&
           is-perfect-square( $number - $reverse );
}

#------------------------------------------------------------------------------
# Adapted from the C++ function PerfectSquare() in
# John D. Cook, "Fast way to test whether a number is a square"
# https://www.johndcook.com/blog/2008/11/17/fast-way-to-test-whether-a-number-
# is-a-square/
#
sub is-perfect-square( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt $h = $n +& 0xF;           # Last hexadecimal "digit"

    return False if $h > 9;           # Return immediately in 6 cases out of 16

    # Take advantage of Boolean short-circuit evaluation

    if $h != 2 && $h != 3 && $h != 5 && $h != 6 && $h != 7 && $h != 8
    {
        my UInt $t = ($n.sqrt + 0.5).floor;      # Take square root if you must

        return $t² == $n;
    }

    return False;
}

#------------------------------------------------------------------------------
sub record-rare-number( UInt:D $n )
#------------------------------------------------------------------------------
{
    state Bool $first = True;

    if $PALINDROMIC || !is-palindrome( $n )
    {
        if $first
        {
            $n.print;
            $first = False;
        }
        else
        {
            ", $n".print;
        }

        $rare-number-found = True;
    }
}

#------------------------------------------------------------------------------
sub is-palindrome( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt @digits = $n.split( '' ).map: { .Int };

    for 0 .. (@digits.end / 2).Int -> UInt $i
    {
        return False unless @digits[ $i ] == @digits[ @digits.end - $i ];
    }

    return True;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
