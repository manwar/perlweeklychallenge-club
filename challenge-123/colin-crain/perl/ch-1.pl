#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       all-numbers-are-beautiful.pl
#
#       Ugly Numbers
#         Submitted by: Mohammad S Anwar
#         You are given an integer $n >= 1.
# 
#         Write a script to find the $nth element of Ugly Numbers.
# 
#         Ugly numbers are those number whose prime factors are 2, 3 or 5. For
#         example, the first 10 Ugly Numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12.
# 
#         Example
#         Input: $n = 7
#         Output: 8
# 
#         Input: $n = 10
#         Output: 12
#
#       notes: 
#         I feel the very notion of numbers constructed solely from the
#         factors 2, 3, and 5 being somehow "ugly" would be quite distressing and
#         offensive to proponents of 5-limit just intonation musical tuning systems,
#         and expressing this sentiment in certain rarefied
#         environments is liable to provoke a hostile, even violent, response.
# 
#         These psycho-temporal explorers, remember, have chosen to live with their
#         minds in the nexus between acoustic vibrations and the cosmos itself,
#         and have left an even temperment — apologies for that pun but you must
#         admit it works — far behind. 
# 
#         I've been listening to Terry Riley's *The Harp of New Albion* quite a lot
#         since the Black Ships came, and consider it an amazing achievement,
#         among the most beautiful things I've ever heard. And all built from ratios
#         of numbers made from 2, 3 and 5. So there. To those that say ugly I
#         laugh openly and derisively at the raw foolishness of the claim.
# 
#         And besides, the numbers don't care one bit about our collective,
#         infitesimally unimportant opinions. They have so, so many better
#         things to do.
# 
#         In honor of constructing note intervals from factors, I will choose a
#         constructive method to compose our sequence.
#  
#         method: 
# 
#         If we start composing numbers using just the products of 2, 3
#         and 5, we can populate a line, order them and find the number at the
#         index requested. This sounds like a sound strategy (I'm going to leave
#         that somewhat awkward phrasing because it reenforces the musical
#         thematic resonance, as does the word "resonance" as well).
# 
#         The question arises, though, is how many values do we need to
#         construct? Well obviously the answer is "enough", but the relative
#         placement of the values constructed from a given number of factors
#         from the pool will be figuratively all over the map. If we are to
#         avoid filtering and factoring scads of values, instead adding the
#         products of (2,2), (2,3), (2,5), (3,3), etc, we need to know when to
#         stop.
# 
#         Ok, perhaps we could stop and check every once in a while, but the
#         problem is that calculating the next sequental value is non-obvious. 5
#         x 5 x 5 = 125, with 3 factors, but earlier than that in the sequence
#         is 2 x 2 x 2 x 2 x 2 x 2 = 64 with 6 factors.
# 
#         Actually I believe that power of 2 example is the key. Our sequence is
#         constructed from numbers found as the product of sets of numbers drawn
#         from our limited pool of three values. These sets will have increasing
#         numbers of elements as our final sequence grows generally larger, but
#         there can be no assumption that a number from a set of *k* elements
#         will necessarily fall after all numbers from the sets with *k*-1
#         elements, and in fact we know this is not true. But what we do know is
#         that for a given number line constructed from all sets of members
#         sized 1 to *k*, that the smallest next number added to the number line
#         will be the smallest value from the set composed of *k*+1 elements.
#         The smallest number that can be created in the set with *k*+1 elements
#         is 2^k+1, so we can therefore conclude that the number line for all
#         sets less than *k* members, for those values less than 2^k+1, is
#         complete and ordered, and can be safely used.
# 
#       method:
# 
#         Because we need to create a very large number of combinations, we will
#         pull out the big guns and use the `combinations_with_repetition()`
#         function from `Algorithm::Combinatorics`. This will give us our
#         required combinations quickly without breaking the bank in memory.
#         Likewise the` List::Util` function `product()` will multiply all the
#         factors to get our result.
# 
#         At each multiset size of factors the new additions to the number line
#         are pushed on and the list sorted, and the number of safe values is
#         computed. If more values are required to produce enough numbers the
#         loop is repeated, adding an additional factor until enough elements
#         have been constructed.
# 
#         The size of the sequence is limited by integer size in the system,
#         S[12691] = 9216000000000000000, the largest number precisely calculable
#         without using the `bigint` pragma.

#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use Algorithm::Combinatorics qw( combinations_with_repetition );
use List::Util               qw( product );

my $request = shift @ARGV // 12691;

$request--;

my @factors = (2, 3, 5);
my @inter = ( 1 );
my @seq;
my $fcount = 0;

while (++$fcount) {

    for my $iter (combinations_with_repetition( \@factors, $fcount)) {
        my $p = product $iter->@*;
       push @inter, $p;  
    }
    @seq = grep { $_ < 2**$fcount+1 } sort {$a<=>$b} @inter;
    last if scalar @seq > $request;
}

say "requested index, 1-based count: ", $request+1;
say "sequence value:  $seq[$request]";

say "sequence computed to ", scalar @seq, " known values";
say "sequence:";
say $_ for @seq;







