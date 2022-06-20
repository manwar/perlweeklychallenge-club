#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       twenty-two-brilliant-numbers.pl
#
#       Brilliant Numbers
#         Submitted by: Mohammad S Anwar
#         Write a script to generate first 20 Brilliant Numbers.
# 
#         Brilliant numbers are numbers with two prime factors of the same length.

#         The number should have exactly two prime factors, i.e. it’s the
#         product of two primes of the same length.
# 
#         For example,
# 
#             24287 = 149 x 163
#             24289 = 107 x 227
# 
#         Therefore 24287 and 24289 are 2-brilliant numbers.
#         These two brilliant numbers happen to be consecutive as there are
#         no even brilliant numbers greater than 14.
# 
#             Output
#             4,   6,   9,   10,  14,  15,  21,  25,  35,  49, 
#             121, 143, 169, 187, 209, 221, 247, 253, 289, 299
# 
#       discussion:

#         right off the bat we seem to have a problem, which is brought out by the
#         puzzling statement in the example, that "24287 and 24289 are
#         2-brilliant numbers". Wait, what are 2-brilliant numbers? Does
#         this refer to the 2 required factors, and if so, does the
#         definition allow of 3- or more briliiant numbers as well?
# 
#         Well, to cut to the chase, yes it does, and so the defintion as
#         atated is incomplete and misleading. This is the defintion for a
#         set of brilliant numbers, and there are in fact others.
# 
#         It appears, then, that the request is for the first 20 brilliant
#         numbers *as defined*, which would mean 2-factor brilliant numbers
#         only. [1]

#         But what even is a brilliant number, and why do they matter? This
#         is less clear, and although the rationale is still rooted in
#         number theory, the does not appear in the end to be a
#         number-theoretical pursuit. Rather, that these numbers are used
#         in other number-theoretical processes.
# 
#         A number with two factors is by definition composite, which of
#         course means it is not prime. And a restriction that the two
#         factors have the same count of digits means they can only vary
#         from another by a factor of nine times the largest largest digit
#         place, and the two will hover around square root of the number
#         factored. One factor, for instance, cannot be very small and the
#         other a low fraction of the product (outside the products of
#         small primes, of course).
# 
#         WHat all this means is that the numbers are not prime, yet of all
#         the composite numbers available the brilliant numbers will be
#         those most difficult to factor using trial division.
# 
#         WHich, apparently, is why these numbers are useful, to provide
#         difficult targets for factoring algorithms. 

#       ---
# 
#         [1] If, on the other hand, we were to want the first 20 brilliant
#         numbers, selected from any order, then the problem becomes much
#         trickier.             


#       ---
# 
#       method:
# 
#         Since ever prime of a givn number of digits times every prime of
#         the same length, inclusive, produces a unique brilliant number,
#         the question remains on ordering them to locate the lowest 20
#         values. I propose we calculate an excess, say the first two
#         orders, and sort the results, selecting the first twenty values
#         from this sorted list.
        
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use ntheory qw( primes );

my @orders = (1,2);
my @bns;

for my $o ( @orders ) {
    my @p = primes( 1 * 10**($o-1), 10**$o - 1 )->@*;
    
    for my $i ( 0..@p-1 ) {
        for my $j ( $i..@p-1 ) {
            push @bns, $p[$i] * $p[$j];
        }
    }
}

@bns = sort {$a<=>$b} @bns;

say "@bns[0..19]";

