#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       mixed-up-and-multiplied.pl
#
#       Permuted Multiples
#         Submitted by: Mohammad S Anwar
#         Write a script to find the smallest integer x such that x, 2x,
#         3x, 4x, 5x and 6x are permuted multiples of each other.
# 
#         For example, the integers 125874 and 251748 are permutated
#         multiples of each other as
# 
#         251784 = 2 x 125874
# 
#         and also both have the same digits but in different order.
# 
#         Output
#         142857
# 
#         Method:
# 
#             Lets spend about 30 seconds thinking this through. I'm not
#             going to thoughly explore the mathematical relationships
#             between digits n multiples of a value, albeit this does sound
#             really interesting. What we can observe, though, is that the
#             multiples do need to have the same number of digits. I mean,
#             that goes without saying, right? It's part of being a
#             permutation, to have the same elements rearranged.
# 
#             SO if we have the same number of digits, the largest
#             multiple, 6x, must still be less than 10 in the rightmost
#             position, or else we'll carry and grow the length.
#             Consequently, the rightmost digit can only be 1. We can even
#             extend this to the next digit from the right must be so the
#             two considered together, when multiplied by 6 are less than
#             100. Or in other words, the righnost pair must be equal to or
#             less than 16.
# 
#             Are we going to consider leading 0s? Aw, hell no. If we do,
#             the answer is trivial: 0.
# 
#             Zero times any number is zero and any arrangement is a valid
#             permutation of itself.
# 
#             So that's boring, and leading 0s are out. 

#             Next we'll conside a number that immediately comes to mind:
#             1/7. The repeating decimal on this, 0.142857, is famous for
#             rearranging the digits n its reptend, and a quick check
#             verifies that the number 142857 satisfies the conditions.
# 
#             So that's an answer, although it does rely on forknowledge of
#             this interesting number and its properties, which I don't
#             particularly like, with regards to the challenge of writing a
#             program to complete the task. But I suppose it does establish
#             an upper bound on the smallest number with the property.
# 
#             I propose we examine all the numbers less than this to see if
#             any of these work, using brute force to test them all. 

#             Oh, and one last note: as we're smewhat stressing the
#             definition of permutation here, conflating digits, their
#             values and their placements, the question arises as to
#             duplicated digits. On the face of it I see no problem: a pair
#             of 1s, for example, can be considered two distinct objects
#             that coincidentally look the same. I see no driving reason to
#             make a distinction between permutations and multiset
#             permutations in this instance. 
# 
#           Results:
# 
#             predictably, 142857 is indeed the smallest value that
#             satisfies the conditions.
# 
#             What I found more interesting were the next two values:
#             1428570 and 1429857.
# 
#             I'd like to go down a rabbit-hole and see what relationships
#             these have to 1/7 but I have too many things to do this
#             afternoon.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use constant  LIMIT => 100_000_000 ;

for ( 1..LIMIT ) {
    say $_ if check_multiples( $_ );
}


sub check_multiples ($n) {
## a multiset permutation will have the same elements in the same quantities.
    my $target_hash = digithash( $n );
    for (2..6) {
        return 0 unless hash_compare( $target_hash, digithash( $n * $_ ));
    }
    return 1;
}


sub hash_compare ($a, $b) {
## compare two hash references for equality in keys and values
    for (keys $a->%*) { 
        return 0 if not exists $b->{$_} or $b->{$_} != $a->{$_};
    }
    return 1;
}

sub digithash ( $n, $hash = {} ) {  
## return a frequency hash reference of digits and occurances
    $hash->{$_}++ for split //, $n;
    return $hash;
}



