#!perl

###############################################################################
=comment

Perl Weekly Challenge 177
=========================

TASK #2
-------
*Palindromic Prime Cyclops*

Submitted by: Mohammad S Anwar

Write a script to generate first 20 Palindromic Prime Cyclops Numbers.


    A cyclops number is a number with an odd number of digits that has a zero
    in the center only.


Output

  101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
  1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
  1360631, 1390931, 1490941, 1520251

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Configuration
-------------
The first $TARGET palindromic prime cyclops numbers (PPCNs) are displayed in
columns, with $N_PER_LN PPCNs per line; vertical alignment is achieved by set-
ting $WIDTH to a suitable value (each PPCN is right-justified in a field $WIDTH
characters wide). Adjust as desired.

Algorithm
---------
Calculation time is kept to a minimum by *constructing* palindromic cyclops
numbers (PCNs) in numerically ascending order, and testing for primality as
they are constructed. Each PCN has the form "oM0Ro" where:

  - o is an outer digit. It is limited to the values 1, 3, 7, and 9, as all
      prime numbers greater than 5 must end in one of these digits.
  - M is a sequence of 0 or more digits which does not contain a zero.
  - 0 is a literal zero.
  - R is the reverse of M.

The primality test is performed by the function is_prime() from the CPAN module
Math::Prime::Util (aka ntheory).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Math::Prime::Util qw( is_prime );

const my $N_PER_LN =>  8;
const my $TARGET   => 20;
const my $USAGE    => "Usage:\n  perl $0\n";
const my $WIDTH    =>  7;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 177, Task #2: Palindromic Prime Cyclops (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";

    my @palindromic_prime_cyclops;

    L_OUTER:
    for (my $digits = 0; ; ++$digits)
    {
        for my $outer (1, 3, 7, 9)
        {
            for my $m (1 x $digits .. 9 x $digits)
            {
                next if $m =~ /0/;

                my $n = $outer . $m . 0 . (reverse $m) . $outer;

                if (is_prime( $n ))
                {
                    push @palindromic_prime_cyclops, $n;

                    last L_OUTER
                         if scalar @palindromic_prime_cyclops >= $TARGET;
                }
            }
        }
    }

    display( \@palindromic_prime_cyclops );
}

#------------------------------------------------------------------------------
sub display
#------------------------------------------------------------------------------
{
    my ($palindromic_prime_cyclops) = @_;

    printf "The first %d palindromic prime cyclops numbers:\n%*d",
                $TARGET, $WIDTH, $palindromic_prime_cyclops->[  0 ];

    for my $i (1 .. $#$palindromic_prime_cyclops)
    {
        printf '%s%*d', ($i % $N_PER_LN == 0 ? ",\n" : ', '),
                         $WIDTH, $palindromic_prime_cyclops->[ $i ];
    }

    print "\n";
}

###############################################################################
