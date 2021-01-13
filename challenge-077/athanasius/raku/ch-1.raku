use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 077
=========================

Task #1
-------
*Fibonacci Sum*

Submitted by: Mohammad S Anwar

You are given a positive integer $N.

UPDATE: 2020-09-07 09:00:00
Write a script to find out all possible combination of Fibonacci Numbers
required to get $N on addition.

You are *NOT* allowed to repeat a number. Print 0 if none found.

Example 1:

 Input: $N = 6

 Output:
     1 + 2 + 3 = 6
     1 + 5 = 6

Example 2:

 Input: $N = 9

 Output:
     1 + 8 = 9
     1 + 3 + 5 = 9

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----

The Fibonacci numbers are: 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, ...
[1],[2], but for this Task they are taken to be:  1, 2, 3, 5, 8, 13, 21, ...
--i.e., 0 is excluded, and 1 is included only once. So the Task may be restated
as follows: find all distinct subsets of the set { 1, 2, 3, 4, 8, 13, 21, ... }
such that the sum of their members equals $N.

Note also that "positive integer" is taken to mean "Natural number", i.e., an
integer > 0, so the case of $N = 0 is excluded.

I have not found any value for $N which produces an empty solution set.

Memoization: For small values of $N, the calculation is already fast and memo-
ization has little effect. But for larger values, the speedup is significant.
For example, with $N = 9,876,543:

    --------------------------------------------
                           Rec. calls   Time (s)
    --------------------------------------------
    Without memoization:       24,451      19.61
    With    memoization:           23       1.73
    --------------------------------------------

or with $N = 98,765,432:

    --------------------------------------------
                           Rec. calls   Time (s)
    --------------------------------------------
    Without memoization:      453,275     545.24
    With    memoization:           30       8.60
    --------------------------------------------

[1] https://oeis.org/A000045
[2] https://en.wikipedia.org/wiki/Fibonacci_number 

=end comment
#==============================================================================

use List::MoreUtils < firstidx lastidx >;
use Memoize;

#------------------------------------------------------------------------------
# File-local variables
#------------------------------------------------------------------------------

my UInt @f_Fibonacci;    # Fibonacci nums: 1, 2, 3, 5, 8, 13, ...
my UInt %f_Cum-sums;     # Fibonacci nums (keys) & their cumulative sums (vals)

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 077, Task #1: Fibonacci Sum (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    UInt:D  $N where { $N > 0 },        #= The target sum (a positive integer)
    Bool:D :$hide-sums = False,         #= Suppress display of all the distinct
                                        #= combinations?
)
##=============================================================================
{
    init-fib-nums($N);

    memoize(&find-fib-sums);

    my Array[UInt] @sums  = find-fib-sums($N);

    display-results($N, @sums, $hide-sums);
}

#------------------------------------------------------------------------------
sub find-fib-sums                                        # Recursive subroutine
(
    UInt:D $N                          # Note: 0 must be allowed here!
--> Array:D[Array:D[UInt:D]]
)
#------------------------------------------------------------------------------
{
    my Array[UInt] @sums;

    if    $N == 0                      # Base case  (a):       0 --> empty sum
    {
        @sums.push: Array[UInt].new();
    }
    elsif $N <= 2                      # Base cases (b) & (c): 1 --> 1, 2 --> 2
    {
        @sums.push: Array[UInt].new($N);
    }
    else                               # Recursive cases
    {
        my UInt $max = lastidx  {             $_  <= $N }, @f_Fibonacci;
        my UInt $min = firstidx { %f_Cum-sums{$_} >= $N }, @f_Fibonacci;

        for @f_Fibonacci[$min .. $max].reverse -> UInt $f
        {
            my Array[UInt] @prev-terms = find-fib-sums($N - $f);
            my Array[UInt] @new-terms;

            for @prev-terms -> Array[UInt] $term
            {
                @new-terms.push: Array[UInt].new(|$term, $f) if $f ∉ $term;
            }

            @sums.append: @new-terms;
        }
    }

    return @sums;
}

#------------------------------------------------------------------------------
sub init-fib-nums( UInt:D $N )
#------------------------------------------------------------------------------
{
    @f_Fibonacci = 1, 2;
    %f_Cum-sums  = 1 => 1, 2 => 3;

    my UInt $fib = 2;
    my UInt $sum = 3;

    until $fib >= $N
    {
        $fib = @f_Fibonacci[*-2] + @f_Fibonacci[*-1];

        @f_Fibonacci.push: $fib;

        $sum += $fib;

        %f_Cum-sums{ $fib } = $sum;
    }
}

#------------------------------------------------------------------------------
sub display-results( UInt:D $N, Array:D[UInt:D] @sums, Bool:D $hide-sums )
#------------------------------------------------------------------------------
{
    my UInt $count = @sums.elems;

    ("Input: \$N = %d\n\n" ~
     "Output: %d %scombination%s of Fibonacci numbers sum%s to %d%s\n").printf:
        $N, $count, $count == 1               ?? ''  !! 'different ',
                    $count == 1               ?? ''  !! 's',
                    $count == 1               ?? 's' !! '',
                $N, $count == 0 || $hide-sums ?? ''  !! ':';

    unless $hide-sums
    {
        "    %s = %d\n".printf: .sort.join(' + '), $N for @sums;
    }
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
