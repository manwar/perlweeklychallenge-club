use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 167
=========================

TASK #1
-------
*Circular Prime*

Submitted by: Mohammad S Anwar

Write a script to find out first 10 circular primes having at least 3 digits
(base 10).

Please checkout [ https://en.wikipedia.org/wiki/Circular_prime |wikipedia] for
more information.


        A circular prime is a prime number with the property that the number
        generated at each intermediate step when cyclically permuting its (base
        10) digits will also be prime.


Output

  113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Note
----
There are 2 definitions of "circular primes":

 1. "Numbers such that every cyclic permutation is a prime" [2]:
    2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97, 113, 131, 197, 199, ...
 2. As in 1, except that "Only the smallest member of the cyclic shift is
    listed." [1]: 2, 3, 5, 7, 11, 13, 17, 37, 79, 113, 197, 199, 337, 1193, ...

From the output shown in the Task description, it is evident that the circular
primes required here are those which satisfy definition 2.

Algorithm
---------
In base 10, all circular primes of 2 or more digits must be composed of the
digits 1, 3, 7, or 9 only.
    Rationale:
        any 2+ -digit integer ending in 0             is divisible by 2 and 5;
        any 2+ -digit integer ending in 2, 4, 6, or 8 is divisible by 2;
        any 2+ -digit integer ending in 5             is divisible by 5;
    and in any cycle, each digit must appear at least once in final position.

Accordingly, the algorithm begins by *constructing* possible solutions (i.e.,
integers containing just those digits):

1.  Let circ_primes = ()
2.  Find all combinations of 3-, 4-, 5-, and 6-digits drawn from the set
    {1, 3, 7, 9}. Note: as these are *combinations*, order is unimportant. For
    convenience, the digits in each combination are sorted in ascending numeri-
    cal order.
3.  Filter out combinations containing all 3s, all 7s, and all 9s.
        Rationale: Any integer of 2 or more digits in which the digits are all
                   3, 7, or 9 is divisible by the repunit of the same length.
                   For example, 7777 = 1111 * 7.
4.  FOR each combination c
        5.  Generate all the permutations of the digits in c
        6.  WHILE  there are permutations remaining
                 7. Remove the first permutation and store as p
                 8. Generate the cycle of integers beginning with p
                 9. If every member of the cycle is prime, store p in
                    circ_primes
                10. Remove all members of the cycle from the remaining permuta-
                    tions
            ENDWHILE
    ENDFOR
11. Display the contents of circ_primes

Table of Circular Primes
------------------------
From [1]: 2, 3, 5, 7, 11, 13, 17, 37, 79,
          113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933,
          1111111111111111111, 11111111111111111111111

References
----------
[1] "A016114  Circular primes (numbers that remain prime under cyclic shifts of
     digits).", OEIS, https://oeis.org/A016114
[2] "A068652  Numbers such that every cyclic permutation is a prime.", OEIS,
     https://oeis.org/A068652
[3] "Circular prime", Wikipedia, https://en.wikipedia.org/wiki/Circular_prime

=end comment
#==============================================================================

my      constant @DIGITS =  1, 3, 7, 9;
my UInt constant $TARGET = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 167, Task #1: Circular Prime (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @combs = get-combinations();
            @combs = filter-reps( @combs );
    my UInt @circ-primes;

    for @combs -> UInt $comb
    {
        @circ-primes.push: |find-circular-primes( $comb );

        last if +@circ-primes >= $TARGET;
    }

    "Output: %s\n".printf: @circ-primes[ 0 .. $TARGET - 1 ].join: ', ';
}

#------------------------------------------------------------------------------
sub find-circular-primes( UInt:D $num --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @circ-primes;
    my UInt @perms = get-permutations( $num );

    while @perms
    {
        my UInt $perm      = @perms.shift;
        my UInt @cycle     = get-cycle( $perm );
        my Bool $all-prime = True;

        for @cycle -> UInt $n
        {
            unless $n.is-prime
            {
                $all-prime = False;
                last;
            }
        }

        @circ-primes.push: $perm if $all-prime;

        for @cycle -> UInt $n
        {
            my UInt $i = @perms.first: * == $n, :k;

            @perms.splice: $i, 1 if $i.defined;
        }
    }

    return @circ-primes;
}

#------------------------------------------------------------------------------
# E.g., 137 -> 713 -> 371 [-> 137]
#
sub get-cycle( UInt:D $first --> Array:D[UInt:D] ) 
#------------------------------------------------------------------------------
{
    my UInt @cycle  = $first;
    my UInt @digits = $first.split( '', :skip-empty ).map: { .Int };
    my UInt $next;

    repeat
    {
        my $last = @digits.pop;
        @digits  = $last, |@digits;
        $next    = @digits.join( '' ).Int;

        @cycle.push: $next;

    } until $next == $first;

    @cycle.pop;

    return @cycle;
}

#------------------------------------------------------------------------------
sub get-permutations( UInt:D $n --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    # Note: the digits are already sorted (ascending)

    my UInt @digits = $n.split( '', :skip-empty ).map: { .Int };

    my Array[UInt] @perms = Array[Array[UInt]].new:
                            @digits.permutations.map: { Array[UInt].new: $_ };

    my UInt %perm{UInt};

    ++%perm{ .join.Int } for @perms;

    return Array[UInt].new: %perm.keys.sort;
}

#------------------------------------------------------------------------------
sub get-combinations( --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @combs;

    for @DIGITS -> UInt $a
    {
        for @DIGITS -> UInt $b
        {
            next if $b < $a;

            for @DIGITS -> UInt $c
            {
                next if $c < $b;

                @combs.push: "$a$b$c".Int;

                for @DIGITS -> UInt $d
                {
                    next if $d < $c;

                    @combs.push: "$a$b$c$d".Int;

                    for @DIGITS -> UInt $e
                    {
                        next if $e < $d;

                        @combs.push: "$a$b$c$d$e".Int;

                        for @DIGITS -> UInt $f
                        {
                            next if $f < $e;

                            @combs.push: "$a$b$c$d$e$f".Int;
                        }
                    }
                }
            }
        }
    }

    return @combs;
}

#------------------------------------------------------------------------------
# Remove 333, 777, 999, 3333, ..., but NOT 111, 1111, ...
#
sub filter-reps( Array:D[UInt:D] $combs --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @filtered;

    for @$combs -> $comb
    {
        my UInt @digits = $comb.split( '', :skip-empty ).map: { .Int };
        my UInt %count;

        ++%count{ $_ } for @digits;

        if %count{ 1 }:exists || %count.keys.elems > 1
        {
            @filtered.push: $comb;
        }
    }

    @filtered.= sort: { .chars, .Int };

    return @filtered;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
