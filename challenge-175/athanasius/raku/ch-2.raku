use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 175
=========================

TASK #2
-------
*Perfect Totient Numbers*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Perfect Totient Numbers. Please checkout
[ https://en.wikipedia.org/wiki/Perfect_totient_number |wikipedia page] for
more informations.

Output

  3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
  2187, 2199, 3063, 4359, 4375, 5571

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Totients and Iterated Totients
------------------------------
"In number theory, Euler's totient function counts the positive integers up to
a given integer n that are relatively prime to n. ... In other words, it is the
number of integers k in the range 1 ≤ k ≤ n for which the greatest common
divisor gcd(n, k) is equal to 1." [5] For all n > 2, φ(n) is even.

Since gcd(n, n) = n, it follows that, for all n > 1, φ(n) is at most n - 1
(when happens when n is prime), so φ(n) < n. So when totients are iterated, the
iterations always eventually decrease to 2, and then to 1.

Perfect Totient Numbers
-----------------------
AFAICT, the definitions of Perfect Totient Numbers (PTNs) given in [6] and [2]
imply that 1 is a PTN, which it is not. A more rigorous definition is given in
[4], which specifies that a PTN must be > 2.

"It is trivial that perfect totient numbers must be odd. It is easy to show
that powers of 3 are perfect totient numbers." [2]

Solution
--------
Function euler-phi() calculates φ(n) using Euler's product formula [5]:

  φ(n) = n ∏ (1 - 1/p)   where p ranges over the distinct primes that divide n.

The prime factors of n are calculated by the recursive function prime-factors()
which in turn uses Raku's native is-prime() method.

Subroutine iterated-totient-sum() calls euler-phi() repeatedly until the itera-
tions reduce to 2. The iterations are summed progressively, and finally 1 is
added for φ(2).

The main routine calls iterated-totient-sum() repeatedly on successive odd
numbers: those for which the iterated totient sum equals the number itself are
PTNs. The search continues until $TARGET PTNs have been found and displayed.
For $TARGET = 20, the complete search takes 14 seconds on my machine.

References
----------
[1] "A000010  Euler totient function phi(n): count numbers <= n and prime to
     n.", OEIS, https://oeis.org/A000010
[2] "A082897  Perfect totient numbers.", OEIS, https://oeis.org/A082897
[3]  Dana Jacobsen, "Math::Prime::Util", MetaCPAN,
     https://metacpan.org/pod/Math::Prime::Util
[4]  Douglas E. Iannucci, Deng Moujie, and Graeme L. Cohen, "On Perfect Totient
     Numbers", Journal of Integer Sequences, Vol. 6 (2003),
     http://www.emis.de/journals/JIS/VOL6/Cohen2/cohen50.pdf
[5] "Euler's totient function", Wikipedia,
     https://en.wikipedia.org/wiki/Euler%27s_totient_function
[6] "Perfect totient number", Wikipedia,
     https://en.wikipedia.org/wiki/Perfect_totient_number

=end comment
#==============================================================================

my UInt constant $TARGET = 20;
my Bool constant $TIME   = False;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 175, Task #2: Perfect Totient Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN()
#==============================================================================
{
    my Int $t0 = time if $TIME;

    "The first $TARGET Perfect Totient Numbers:\n\n3".print;

    my UInt $count = 1;

    loop (my UInt $n = 5; $count < $TARGET; $n += 2)
    {
        if (iterated-totient-sum( $n ) == $n)
        {
            ", $n".print;
            ++$count;
        }
    }

    put();

    "\n%d seconds\n".printf: time - $t0 if $TIME;
}

#------------------------------------------------------------------------------
sub iterated-totient-sum( UInt:D $n where { $n > 1 } --> UInt:D )
#------------------------------------------------------------------------------
{
    my UInt $i   = $n;
    my UInt $sum = 0;

    while $i > 2
    {
        $i    = euler-phi( $i );
        $sum += $i;
    }

    return ++$sum;      # euler-phi(2) = 1
}

#------------------------------------------------------------------------------
sub euler-phi( UInt:D $n where { $n > 1 } --> UInt:D )
#------------------------------------------------------------------------------
{
    # phi(n) = n * Product_{distinct primes p dividing n} (1 - 1/p)

    my UInt @prime-factors = prime-factors( $n ).unique;
    my Rat  $phi           = $n * [*] @prime-factors.map: { 1 - (1 / $_) };

    return $phi.Int;
}

#------------------------------------------------------------------------------
sub prime-factors( UInt:D $n where { $n > 1 } --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @prime-factors;

    if $n.is-prime
    {
        @prime-factors.push: $n;
    }
    else
    {
        for 2, 3, 5, 7 ... * -> UInt $p
        {
            if $p.is-prime && $n %% $p
            {
                @prime-factors.push: $p, |prime-factors( ($n / $p).Int );
                last;
            }
        }
    }

    return @prime-factors;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
