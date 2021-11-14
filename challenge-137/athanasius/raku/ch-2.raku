use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 137
=========================

TASK #2
-------
*Lychrel Number*

Submitted by: Mohammad S Anwar

You are given a number, 10 <= $n <= 1000.

Write a script to find out if the given number is Lychrel number. To keep the
task simple, we impose the following rules:

 a. Stop if the number of iterations reached 500.
 b. Stop if you end up with number >= 10_000_000.

[UPDATED][2021-11-01 16:20:00]: If you stop because of any of the above two
rules then we expect 1 as an output.

According to [ https://en.wikipedia.org/wiki/Lychrel_number |wikipedia]:

A Lychrel number is a natural number that cannot form a palindrome through the
iterative process of repeatedly reversing its digits and adding the resulting
numbers.

Example 1

  Input: $n = 56
  Output: 0

  After 1 iteration, we found palindrome number.
  56 + 65 = 121

Example 2

  Input: $n = 57
  Output: 0

  After 2 iterations, we found palindrome number.
   57 +  75 = 132
  132 + 231 = 363

Example 3

  Input: $n = 59
  Output: 0

  After 3 iterations, we found palindrome number.
   59 +  95 =  154
  154 + 451 =  605
  605 + 506 = 1111

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Definitions
-----------
1. Let rev(N) be defined as the integer formed by reversing the digits of N (as
   represented in decimal notation). Where the least significant digit(s) of N
   are 0s (zeros), rev(N) has fewer digits than N. For example, rev(1200) =
   "0021" = 21.
2. Let an _Iteration_ be defined as the production of a new term from the
   previous term as follows: term[N+1] = term[N] + rev(term[N])
3. Let a Lychrel number be defined as a number N such that no finite series of
   _Iterations_ beginning with term[0] = N results in a term which is a
   palindrome.

Notes:

(i) "In base ten, no Lychrel numbers have been yet proved to exist, but many,
     including 196, are suspected on heuristic and statistical grounds."
     (Wikipedia). An output of 1 is therefore an indication that the given $n
     is *probably* a Lychrel number.

(ii) There is an ambiguity in the definition of Lychrel numbers: how are we to
     treat the degenerative case in which term[0] is a palindrome, but no
     term[x: x > 0] is a palindrome?

     (a) If a finite series of _Iterations_ is taken to mean *one or more*,
         then a palindromic N might be a Lychrel number (OEIS A088753)
     (b) Otherwise -- i.e., if a finite series is *zero or more* -- then a
         palindromic N is by definition NOT a Lychrel number (OEIS A023108).

     The first palindromic value of N to otherwise satisfy Definition 3 is
     9999. Since this is greater than the maximum value of 1000 specified in
     the Task Description, I have simply assumed interpretation (b) and
     included up-front a test to eliminate palindromic values of N as non-
     Lychrel numbers.

Interface
---------
By default, the solution below displays the result (0 = $n is not a Lychrel
number, 1 = $n is probably a Lychrel number) followed by an explanation of how
this result was reached. The explanation may be omitted by including the flag
--terse on the command line.

=end comment
#==============================================================================

my UInt constant $MIN-N    =         10;
my UInt constant $MAX-N    =      1_000;
my UInt constant $MAX-ITER =        500;
my UInt constant $MAX-TERM = 10_000_000;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 137, Task #2: Lychrel Number (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    UInt:D  $n where { $MIN-N <= $n <= $MAX-N },   #= A decimal integer between
                                                   #=   10 and 1000 inclusive
    Bool:D :$terse = False                         #= Omit the explanation?
)
#==============================================================================
{
    "Input:  \$n = $n".put;

    my Bool $is-lychrel = False;
    my Str  $explanation;

    if is-palindrome( $n )
    {
        $explanation = '$n is already a palindrome';
    }
    else
    {
       ($is-lychrel, $explanation) = iterate( $n );
    }

    "Output: %d\n".printf: $is-lychrel ?? 1 !! 0;

    "\nExplanation: $explanation".put unless $terse;
}

#------------------------------------------------------------------------------
sub iterate( UInt:D $n --> Array:D[ Bool:D, Str:D ] )
#------------------------------------------------------------------------------
{
    my Bool $is-lychrel  =  True;
    my Str  $explanation = "Reached the limit of $MAX-ITER iterations " ~
                           'without finding a palindrome';
    my UInt $term        =  $n;

    for 1 .. $MAX-ITER -> UInt $i
    {
        # Reverse then add

        my UInt @digits  = $term.split( '', :skip-empty ).map: { .Int };
        my UInt $reverse = @digits.reverse.join( '' ).Int;
                $term   += $reverse;

        if is-palindrome( $term )
        {
            $is-lychrel  =  False;
            $explanation = 'Palindrome %d found after %d iteration%s'.sprintf:
                            $term, $i, $i == 1 ?? '' !! 's';
            last;
        }

        if $term >= $MAX-TERM
        {
            $explanation = 'Term %d too large after %d iteration%s'.sprintf:
                            $term, $i, $i == 1 ?? '' !! 's';
            last;
        }
    }

    return [ $is-lychrel, $explanation ];
}

#------------------------------------------------------------------------------
sub is-palindrome( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my UInt @digits  = $n.split( '', :skip-empty ).map: { .Int };
    my UInt $reverse = @digits.reverse.join( '' ).Int;

    return $reverse == $n;
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
