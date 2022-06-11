use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 164
=========================

TASK #1
-------
*Prime Palindrome*

Submitted by: Mohammad S Anwar

Write a script to find all prime numbers less than 1000, which are also palin-
dromes in base 10. Palindromic numbers are numbers whose digits are the same in
reverse. For example, 313 is a palindromic prime, but 337 is not, even though
733 (337 reversed) is also prime.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $MAX = 1_000;

#==============================================================================
=begin comment

Observations
------------
(1) From [1], the first 42 palindromic primes in base 10 are:
       2,     3,     5,     7,    11,   101,   131,   151,   181,   191,   313,
     353,   373,   383,   727,   757,   787,   797,   919,   929, 10301, 10501,
   10601, 11311, 11411, 12421, 12721, 12821, 13331, 13831, 13931, 14341, 14741,
   15451, 15551, 16061, 16361, 16561, 16661, 17471, 17971, 18181

(2) Also from [1]:
    "Every palindrome with an even number of digits is divisible by 11, so 11
     is the only member of the sequence with an even number of digits. - David Wasserman, Sep 09 2004"

Algorithm
---------
Set @palindromes = ()
FOR each integer n in the range 1 to $MAX - 1:
    IF n = 11 or n has an odd number of digits THEN
        IF n is prime THEN
            Test n to determine whether it is a palindrome:
            - if every digit in n's first half matches its corresponding (i.e.,
              reflected) digit in n's second half, then n is a palindrome;
            - if any digits do not match, then n is not a palindrome
            For example, 474 is a palindrome because the first digit matches
            the last (and the middle digit matches itself)
            IF n is a palindrome THEN
                push n onto @palindromes
            ENDIF
        ENDIF
    ENDIF
ENDFOR
Output @palindromes

References
----------
[1] "A002385  Palindromic primes: prime numbers whose decimal expansion is a
     palindrome.", OEIS, http://oeis.org/A002385
[2] "Palindromic prime", Wikipedia,
     https://en.wikipedia.org/wiki/Palindromic_prime
[3] "Palindromic primes", OEIS, http://oeis.org/wiki/Palindromic_primes

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 164, Task #1: Prime Palindrome (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my UInt @pr-pals;

    for 1 ..^ $MAX -> UInt $n
    {
        next if $n > 11 && $n.chars %% 2;

        @pr-pals.push: $n if is-prime( $n ) && is-palindrome( $n );
    }

    ('The %d prime numbers less than %d which are also palindromes in base ' ~
        "10:\n%s\n").printf: +@pr-pals, $MAX, @pr-pals.join: ', '; 
}

#------------------------------------------------------------------------------
sub is-palindrome( UInt:D $n --> Bool:D )
#------------------------------------------------------------------------------
{
    my Str @digits = $n.split: '', :skip-empty;

    for 0 .. (+@digits / 2).floor -> UInt $i
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

###############################################################################
