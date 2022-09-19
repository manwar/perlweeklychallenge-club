#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

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
The CPAN module Math::Prime::Util [3] provides function euler_phi(), which cal-
culates the totient of a given integer very quickly. (For a home-grown imple-
mentation of euler_phi(), see the Raku solution to Task 2.)

Subroutine iterated_totient_sum() calls euler_phi() repeatedly until the itera-
tions reduce to 2. The iterations are summed progressively, and finally 1 is
added for φ(2).

The main routine calls iterated_totient_sum() repeatedly on successive odd
numbers: those for which the iterated totient sum equals the number itself are
PTNs. The search continues until $TARGET PTNs have been found and displayed.

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( euler_phi );

const my $TARGET => 20;
const my $USAGE  => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 175, Task #2: Perfect Totient Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    print "The first $TARGET Perfect Totient Numbers:\n\n3";

    my $count = 1;

    for (my $n = 5; $count < $TARGET; $n += 2)
    {
        if (iterated_totient_sum( $n ) == $n)
        {
            print ", $n";
            ++$count;
        }
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub iterated_totient_sum
#------------------------------------------------------------------------------
{
    my ($n)  = @_;
    my  $sum = 0;

    while ($n > 2)
    {
        $n    = euler_phi( $n );
        $sum += $n;
    }

    return ++$sum;      # euler_phi(2) = 1
}

###############################################################################
