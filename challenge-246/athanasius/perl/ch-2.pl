#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, and the given sequence does form a linear
   recurrence of the second order, the values of p and q are shown in the
   recurrence relation.

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

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $EPSILON => 1e-9;
const my $USAGE   =>
"Usage:
  perl $0 [<a> ...]
  perl $0

    [<a> ...]    A list of 5 integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 246, Task #2: Linear Recurrence of Second Order (Perl)" .
                                                                        "\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @a = @ARGV;

        / ^ $RE{num}{int} $ /x   or error( qq["$_" is not a valid integer] )
                for @a;

        my $argc = scalar @a;
           $argc == 5            or error( "Expected 5 integers, found $argc" );

        printf "Input:  \@a = (%s)\n", join ', ', @a;

        my ($p, $q)  = solve( \@a );
        my  $success = defined $p && defined $q;

        printf "Output: %s\n", $success ? 'true' : 'false';

        if ($VERBOSE && $success)
        {
            print  "\nRecurrence relation:\n";
            printf   "  a[n] = %d * a[n-2] %s %d * a[n-1]\n",
                        $p, ($q < 0 ? '-' : '+'), abs $q;
        }
    }
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my ($p, $q);
    my ($a, $b, $c, $d, $e) = @$ints;

    # p = (bd - c²) / (b² - ac)

    my  $divisor = $b * $b - $a * $c;

    if ($divisor && $b)
    {
        my $p_ = ($b * $d - $c * $c) / $divisor;

        if (is_int( $p_ ))
        {
            #   q  = (c - a[ (bd - c²) / (b² - ac) ]) / b

            my $q_ = ($c - $a * ( ($b * $d - $c * $c) / $divisor )) / $b;

            if (is_int( $q_ ))
            {
                my $exp_e = $p_ * $c + $q_ * $d;

                ($p, $q) = ($p_, $q_) if is_int( $exp_e ) && $e == $exp_e;
            }
        }
    }

    return ($p, $q);
}

#-------------------------------------------------------------------------------
sub is_int
#-------------------------------------------------------------------------------
{
    abs( $_[ 0 ] - int( $_[ 0 ] ) ) < $EPSILON;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $exp_p, $exp_q) = split / \| /x, $line;

        for ($test_name, $ints_str, $exp_p, $exp_q)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  @ints   = split / \s+ /x, $ints_str;
        my ($p, $q) = solve( \@ints );

        if (defined $p)
        {
            is $p, $exp_p, "$test_name: p";
            is $q, $exp_q, "$test_name: q";
        }
        else
        {
            is $exp_p, '', "$test_name: p";
            is $exp_q, '', "$test_name: q";
        }
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1  | 1 1  2    3    5| 1|  1
Example 2  | 4 2  4    5    7|  |
Example 3  | 4 1  2   -3    8| 1| -2
Example 3a | 4 1  2   -3    9|  |
Run of same| 1 1  1    1    1|  |
Zero b     |-1 0 -1    0   -1|  |
Large 1    | 1 1 25 -383 7561|42|-17
Large 1a   | 1 1 25 -383 7560|  |
