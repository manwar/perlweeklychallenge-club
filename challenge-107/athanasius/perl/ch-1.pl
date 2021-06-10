#!perl

###############################################################################
=comment

Perl Weekly Challenge 107
=========================

Task #1
-------
*Self-descriptive Numbers*

Submitted by: Mohammad S Anwar

Write a script to display the first three self-descriptive numbers. As per
[ https://en.wikipedia.org/wiki/Self-descriptive_number |wikipedia], the
definition of Self-descriptive Number is

        In mathematics, a self-descriptive number is an integer m that in a
        given base b is b digits long in which each digit d at position n (the
        most significant digit being at position 0 and the least significant at
        position b−1) counts how many instances of digit n are in m.

For example:

  1210 is a four-digit self-descriptive number:

     position 0 has value 1 i.e. there is only one 0 in the number
     position 1 has value 2 i.e. there are two 1 in the number
     position 2 has value 1 i.e. there is only one 2 in the number
     position 3 has value 0 i.e. there is no 3 in the number

Output

     1210, 2020, 21200

WARNING:

I realised just before the launch this task was also part of the week 43 and
contributed by Laurent Rosenfeld. It is too late to change now. Feel free to
share your previous solutions if you took part in the week 43 already. I should
have been more carefull, sorry.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Mathematics
-----------
"[A] self-descriptive number is an integer m that in a given base b is b digits
long in which each digit d at position n (the most significant digit being at
position 0 and the least significant at position b−1) counts how many instances
of digit n are in m." (Wikipedia)

Let the digits be labelled x_0 .. x_b-1 (left to right) and let D be the set of
digits in m:

    (1) D = { x_n : 0 <= n < b }

Since D comprises counts of all possible digits in m, the sum of the counts
equals the total number of digits:

    (2) SUM(D) = |D| = b

In any integer m, the most significant digit is non-zero, so

    (3) x_0 > 0

Let E be the set of all non-zero digits in m other than the first:

    (4) E = { x_n : 0 < n < b  ∧  x_n > 0 }

The number of non-zero digits in m other than the first is equal to the total
number of digits in m, less one for x_0, less the number of zero digits (viz.
x_0):

    (5) |E| = b - x_0 - 1

The sum of the non-zero digits in m other than the first is equal to the sum of
all the digits other than the first, since 0-digits do not contribute to the
sum:

    (6) SUM(E) = b - x_0

Combining (5) and (6) gives:

    (7) |E| = b - x_0 - 1
            = SUM(E)  - 1    <=>    SUM(E) = |E| + 1

Since the digits in E are all non-zero, the minimum value of SUM(E) must obtain
when all the digits are 1, in which case SUM(E) is |E|. But we know that SUM(E)
is 1 greater than |E|, so exactly one of the digits in E must be 2:

    (8) "This means, other than the first digit, the set of all other non-zero
         digits consists of several ones and 1 two." (Khovanova)

References:

"Self-descriptive Number", Wikipedia.
    https://en.wikipedia.org/wiki/Self-descriptive_number

Sloane, N. J. A. (ed.). "Sequence A046043 (Autobiographical numbers)". The
    On-Line Encyclopedia of Integer Sequences. OEIS Foundation.
    https://oeis.org/A046043

Tanya Khovanova. "Autobiographical Numbers". arXiv:0803.0270 [math.CO], 2008.
    https://arxiv.org/abs/0803.0270v1

Algorithm
---------
Candidate solutions in bases 2 up to 10 are constructed as follows:
- For each possible value of x_0, the number of 1 digits in m is calculated and
  then an array of length base-minus-2 is built from these 1-digits together
  with the required complement of 0-digits. The array is sorted with zeros
  preceding ones, i.e., in lowest numerical order.
- A 2-digit is placed at each possible position in m.
- The remaining positions are filled from the array of zeros and ones, which is
  permuted until it returns to its original order.
- In this way, every possible combination of x_0, one "2", and the required
  number of ones and zeros is produced.
- Each candidate solution is tested to determine whether it meets the require-
  ments of a self-descriptive number.

Usage
-----
The required number of solutions may be specified by changing the value of the
$TARGET_SOLNS constant.

Note that although the Task asks for only the first 3 self-descriptive numbers,
the full complement of 7 self-descriptive numbers is produced quickly (in less
than a second) using the algorithm described above; therefore $TARGET_SOLNS has
been set to 8 (to ensure that the entire solution space is searched).

=cut
#==============================================================================

use strict;
use warnings;
use Algorithm::Loops qw( NextPermuteNum );
use Const::Fast;

const my $MAX_BASE     => 10;
const my $MAX_SOLNS    =>  7;
const my $TARGET_SOLNS =>  8;
const my $USAGE        => "Usage:\n  perl $0\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 107, Task #1: Self-descriptive Numbers (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;
       $args == 0 or die 'ERROR: Expected 0 command line arguments, found ' .
                         "$args\n$USAGE";
    my @solutions;

    BASE: for my $base (2 .. $MAX_BASE)
    {
        for my $x0 (1 .. $base - 1)          # First digit, the "0" digit count
        {
            my $ones = $base - $x0 - 2;

            if ($ones >= 0)
            {
                my @binaries = ((0) x $x0, (1) x $ones);

                do
                {
                    for my $i (reverse( 1 .. $base - 1 ))  # Index of "2" digit
                    {
                        my $m  = $x0;
                           $m .= $binaries[ $_ ] for 0 .. $i - 2;
                           $m .= 2;
                           $m .= $binaries[ $_ ] for $i - 1 .. $#binaries;

                        if (is_self_desc( $m ))
                        {
                            push @solutions, $m;
                            last BASE if scalar @solutions == $TARGET_SOLNS;
                        }

                    }

                } while (NextPermuteNum( @binaries ));
            }
        }
    }

    printf "The %s%d self-descriptive numbers are:\n\n    %s\n",
            scalar @solutions == $MAX_SOLNS ? '' : 'first ',
            scalar @solutions, join ', ', @solutions;
}

#------------------------------------------------------------------------------
sub is_self_desc
#------------------------------------------------------------------------------
{
    my ($m)           = @_;
    my  @digits       = split //, $m;
    my  $base         = scalar @digits;
    my  $is_self_desc = 0;

    if (1 < $base <= $MAX_BASE)
    {
        my @counts = (0) x $base;
         ++$counts[ $_ ] for @digits;

        my $new_m = join '', @counts;

        $is_self_desc = ($new_m == $m);
    }

    return $is_self_desc;
}

###############################################################################
