use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 246
=========================

TASK #2
-------
*Linear Recurrence of Second Order*

Submitted by: Jorg Sommrey

You are given an array @a of five integers.

Write a script to decide whether the given integers form a linear recurrence of
second order with integer factors.

A linear recurrence of second order has the form

  a[n] = p * a[n-2] + q * a[n-1] with n > 1

  where p and q must be integers.

Example 1

  Input: @a = (1, 1, 2, 3, 5)
  Output: true

  @a is the initial part of the Fibonacci sequence a[n] = a[n-2] + a[n-1]
  with a[0] = 1 and a[1] = 1.

Example 2

  Input: @a = (4, 2, 4, 5, 7)
  Output: false

  a[1] and a[2] are even. Any linear combination of two even numbers with 
  integer factors is even, too.
  Because a[3] is odd, the given numbers cannot form a linear recurrence of
  second order with integer factors.

Example 3

  Input: @a = (4, 1, 2, -3, 8)
  Output: true

  a[n] = a[n-2] - 2 * a[n-1]

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.
3. If VERBOSE is set to True, and the given sequence does form a linear recur-
   rence of the second order, the values of p and q are shown in the recurrence
   relation.

Analysis
--------
Let Z be the set of integers, and let the input list be (a, b, c, d, e) where
each of a ... e is an element of Z. Then, from the recurrence relation:

    a[n] = p * a[n-2] + q * a[n-1] with n > 1

if follows that:

    c = pa + qb     (1)
    d = pb + qc     (2)
and e = pc + qd     (3)

Solving (1) ∧ (2) as 2 simultaneous equations with 2 variables (see below), we
determine the values of p and q in terms of the given constants a, b, c, and d.
If either p or q is not an integer, the input integers do not form a linear
recurrence of the second order with integer factors.

If both p and q are integers, it remains to determine from (3) whether the
derived values of p and q correctly generate e, the fifth term in the series.
If they do, the input integers DO form a linear recurrence relation of the
second order with integer factors.

* * *

Solving (1) and (2) as simultaneous equations:

From (1):   pa + qb = c                         ⊃
            qb =  c - pa                        ⊃
            q  = (c - pa)/b                         (4)

From (2):   pb + qc = d                         ⊃
            pb + c[(c - pa)/b] = d              ⊃   from (4)
            pb + (c² - pac)/b  = d              ⊃
            pb² + c² - pac     = bd             ⊃
            pb² - pac  = bd - c²                ⊃
            p(b² - ac) = bd - c²                ⊃
            p = (bd - c²)/(b² - ac)                 (5)

From (4):   q = (c - pa)/b                      ⊃
            q = (c - a[(bd - c²)/(b² - ac)])/b      from (5)

=end comment
#===============================================================================

use Test;

my UInt constant NUM-INTS = 5;
my Bool constant VERBOSE  = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 246, Task #2: Linear Recurrence of Second Order (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@a where { .elems == NUM-INTS && .all ~~ Int:D }    #= A list of 5 integers
)
#===============================================================================
{
    "Input:  \@a = (%s)\n".printf: @a.join: ', ';

    my Int ($p, $q)  = solve( @a );
    my Bool $success = $p.defined && $q.defined;

    "Output: %s\n".printf: $success ?? 'true' !! 'false';

    if VERBOSE && $success
    {
        "\nRecurrence relation:".put;
          "  a[n] = %d * a[n-2] %s %d * a[n-1]\n".printf:
                    $p, ($q < 0 ?? '-' !! '+'), $q.abs;
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub solve( List:D[Int:D] $ints where { .elems == NUM-INTS } --> List:D[Int:_] )
#-------------------------------------------------------------------------------
{
    my Int ($p, $q);
    my Int ($a, $b, $c, $d, $e) = @$ints;

    #  p = (bd - c²) / (b² - ac)

    my Int $divisor = $b * $b - $a * $c;

    if $divisor && $b
    {
        my Rat $p_ = ($b * $d - $c * $c) / $divisor;

        if $p_.denominator == 1
        {
            #       q  = (c - a[ (bd - c²) / (b² - ac) ]) / b

            my Rat $q_ = ($c - $a * ( ($b * $d - $c * $c) / $divisor )) / $b;

            if $q_.denominator == 1
            {
                my Rat $exp-e = $p_ * $c + $q_ * $d;

                ($p, $q) = $p_.Int, $q_.Int if $e == $exp-e;
            }
        }
    }

    return $p, $q;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $exp-p, $exp-q) = $line.split: / \| /;

        for     $test-name, $ints-str, $exp-p, $exp-q
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints   = $ints-str.split( / \s+ / ).map: { .Int };
        my Int ($p, $q) = solve( @ints );

        if $p.defined
        {
            is $p, $exp-p.Int, "$test-name: p";
            is $q, $exp-q.Int, "$test-name: q";
        }
        else
        {
            is $exp-p, '',     "$test-name: p";
            is $exp-q, '',     "$test-name: q";
        }
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1  | 1 1  2    3    5| 1|  1
        Example 2  | 4 2  4    5    7|  |
        Example 3  | 4 1  2   -3    8| 1| -2
        Example 3a | 4 1  2   -3    9|  |
        Run of same| 1 1  1    1    1|  |
        Zero b     |-1 0 -1    0   -1|  |
        Large 1    | 1 1 25 -383 7561|42|-17
        Large 1a   | 1 1 25 -383 7560|  |
        END
}

################################################################################
