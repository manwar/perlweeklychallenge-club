#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       no-touchee-no-totient.pl
#
#         Perfect Totient Numbers
#         Submitted by: Mohammad S Anwar
# 
#         Write a script to generate first 20 Perfect Totient Numbers. Please
#         checkout wikipedia page for more informations.
# 
# 
#         Output
# 
#             3,    9,    15,   27,  39,   81,   111,  183,  243,  255, 
#             327,  363,  471,  729, 2187, 2199, 3063, 4359, 4375, 5571

#         method:
# 
#             First things first, what is a totient number? What is is, in
#             the most literally descripive sense, is the count of positve
#             integer values less than the number that are also coprime
#             with it — that is to say the two numbers do not share a
#             common prime factor.
# 
#             The obvious followup question, *why* do this, is considerably
#             harder to answer. The function it turns out appears in several
#             analyses in prime factorization, which makes a certain intuitive
#             sense, as well as an analysis of the greatest common divisor
#             function, in which we can see further relation to the underlying
#             process of serching through divisors.
# 
#             One of the most interesting appearances of the function is in an
#             equality binding Binet's closed form equation for the Fibonacci
#             sequesnce, the Möbius function and Eular's totient function. It's
#             not quite *e*<sup>π<i>i</i></sup> but it's getting there.
# 
#             The most visible use of the totient function identiies in in
#             the basis of the RSA encryption scheme, where an application
#             of the function is used to construct the public encryption
#             key for the process. 
# 
#             But wait! We're only halfway there. Or really, practically
#             speaking, we've only now just gotten into the car. To
#             actually arrive at our destination, we calculate the totient
#             as an iterated function
#             (https://en.wikipedia.org/wiki/Iterated_function), repplying
#             the function to the previously calculated totient until a
#             value if 1 is reached.
# 
#             As the totient must be less than or equal to the number it's
#             derived from — we're making a count of numbers from the range
#             1 to the number — the iteration inexorably drives the result
#             downward until 1 is reached. The totient of 1 is 1, so past
#             that point the iteration is defined.
# 
#             The odd part is that once we have achieved a totient of 1, we
#             sum the previous sequence, including the final 1. If this
#             value equals the original number, we have a perfect totient
#             number. This is analogous to a perfect number, where the
#             divisors are summed and compared to the source. It is not,
#             however, the complement function, which would be the sum of
#             the non-divisors but rather those numbers who have a GCD of 1
#             with the source, in that they share no prime factors. 
# 
#             The sum of the non-divisors wouldn't be very interesting as
#             far a as perfection goes, as I believe every number above 4
#             will be abundant, or exceed the value. 

#             The perfect totients on the other hand are quite interesting,
#             albeit not particularly practical. 
            
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

## phi is Euler's totient function
use ntheory qw ( euler_phi );

## input
my $limit = shift @ARGV // 20;
my $count = 0;
my $i = 1;
my @out;

while (++$i and $count < 20) {
    $count++ and push @out, $i if $i == iterate_phi($i);
}

## output
say "@out";


sub iterate_phi ( $n, $s = 1 ) {
## given a value we iterate Euler's totient function on it 
## until we arrive at a totient of 1, compounding an aggregate sum of the results 
## this technique skips the final totient, 1, so we add it at the beginning
## - it will always be there.
    $s += $n while ($n = euler_phi($n)) != 1;
    return $s;
}


