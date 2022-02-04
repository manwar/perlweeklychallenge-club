use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 150
=========================

TASK #2
-------
*Square-free Integer*

Submitted by: Mohammad S Anwar

Write a script to generate all square-free integers <= 500.

    In mathematics, a square-free integer (or squarefree integer) is an integer
    which is divisible by no perfect square other than 1. That is, its prime
    factorization has exactly one factor for each prime that appears in it. For
    example, 10 = 2 ⋅ 5 is square-free, but 18 = 2 ⋅ 3 ⋅ 3 is not, because 18
    is divisible by 9 = 3**2.

Example

 The smallest positive square-free integers are
     1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30, ...

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
From Vladimir Shevelev in [1], "an Eratosthenes-type sieve for squarefree num-
bers":
  1. Record 1 as a square-free number
  2. Create a sieve for numbers 2 to MAX. Each entry is either true (the number
     is square-free) or false (the number is not square-free). Initialize all
     numbers to true.
  3. FOR each number i from 2 to MAX:
         IF sieve[i] is true THEN
             Record i as a square-free number
             FOR each number j in the sequence 2i, 3i, 4i, ..., up to MAX:
                 Toggle the value of sieve[j]: true becomes false, false
                 becomes true
             ENDFOR
         ENDIF
     ENDFOR

Reference
---------
[1] OEIS Foundation Inc. (2022), Squarefree numbers, Entry A005117 in The On-
    Line Encyclopedia of Integer Sequences, https://oeis.org/A005117

=end comment
#==============================================================================

my UInt constant $MAX = 500;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 150, Task #2: Square-free Integer (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Bool @sieve = True xx ($MAX + 1);

    "The square-free integers between 1 and %d (inclusive) are:\n%3d".printf:
        $MAX, 1;

    for 2 .. $MAX -> UInt $i
    {
        if @sieve[ $i ]
        {
            ", %3d".printf: $i;

            # This can also be written as:
            #   for $i * 2, * + $i ... * >= $MAX -> UInt $j
            # but the "loop" version below is slightly faster

            loop (my UInt $j = $i * 2; $j <= $MAX; $j += $i)
            {
                @sieve[ $j ] = !@sieve[ $j ];                # Toggle the value
            }
        }
    }

    put();
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
