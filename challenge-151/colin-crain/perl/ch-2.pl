#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       daylight-robbery.pl
#
#       Rob The House
#         Submitted by: Mohammad S Anwar
#         You are planning to rob a row of houses, always starting with the
#         first and moving in the same direction. However, you can’t rob
#         two adjacent houses.
# 
#         Write a script to find the highest possible gain that can be
#         achieved.
# 
#         Example 1:
#             Input: @valuables = (2, 4, 5);
#             Output: 7
# 
#         If we rob house (index=0) we get 2 and then the only house we can
#         rob is house (index=2) where we have 5. So the total valuables in
#         this case is (2 + 5) = 7.
# 
#         Example 2:
#             Input: @valuables = (4, 2, 3, 6, 5, 3);
#             Output: 13
# 
#         The best choice would be to first rob house (index=0) then rob
#         house (index=3) then finally house (index=5). This would give us
#         4 + 6 + 3 =13.
# 
#       method:

#         In this version of the travelling burglar problem, wait, is that
#         a thing? I thought that was a thing. Oh well, in any case, the
#         goal here is to optimize our selection along an ordered sequence
#         governed by a set of rules:
# 
#             1. we can ony proceed forward
#             2. we must skip the next element in any movement.
#             3. the goal is the highest sum of gathered elements
#             
#         There is no further governance on the selection of elements, but
#         some optimal emergent behavior can be derived to guide us to a
#         winning strategy. For example, from any element we should move
#         forward either 2 or 3 positions. We cannot move one, and any
#         position greater than 3 can be arrived at by some combination of
#         intermediatary steps: position 4 can be broken down into 2 + 2, 5
#         as 2 + 3 or 3 + 2. As all values are positive (or at least 0, but
#         not negative) there is never a downside to adding an intermediate
#         stopover.
# 
#         So 2 or 3 it is.
# 
#         After 2 or 3, however, there is a problem with looking ahead, as
#         the element at position n+4 is always dependant on the choices
#         made previously, as it can only be arrived at in one specific
#         manner. Furthermore, this predicate dependancy can be
#         indefinitely extended to the chain of all 2-separate values,
#         which can only be achieved by making the 2-selectiomn from the
#         very beginning. There are two such sequences in every list,
#         corresponding to the ood- and even-numbered indices, that
#         maximize the number of elements selected, that can only be
#         arrived at by making specific mutulaly-exclusive choices at the
#         beginning of the run.
# 
#         In short, in order to sum these sequences, each needs to be
#         started separately and run through completely, examining every
#         element. As they may also contain the maximal sum, then therefore
#         we need to look at every value before we can make the
#         determination of which pattern maximizes the sum.
# 
#         So we need to look at all the patterns first. There's no escaping
#         that. Or at least the whole list of values. Maybe not every
#         pattern, actually. But pruniing the search tree will be tricky if
#         it's even possible.
# 
#         It looks like we will need ot look at every pattern of 2- and
#         3-jumps, starting at either the 0th or 1st position.
# 
#         As we are tasked with robbing real imaginary houses along a real
#         imaginary block we can assume the number of houses to be finite
#         and not excessively large. But the algorithm will bog down
#         eventually, just to put that out front. 
# 
#         
#         
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


our @arr = (
1, 2, 3, 6, 5, 3, 8, 1, 1, 1, 
2, 3, 6, 5, 3, 8, 1, 1, 1, 2, 
3, 6, 5, 3, 8, 1, 1, 1, 2, 3, 
6, 5, 3, 8, 1, 1, 1, 2, 3, 6, 
5, 3, 8, 1, 1, 1, 2, 3, 6, 5, 
3, 8, 1, 1, 1, 2, 6, 5, 3, 8 );


say lookahead( );

sub lookahead ( $pos = -2, $sum = 0 ) {
    return $sum if $pos > $#arr;
    $sum += $arr[ $pos ] if $pos >= 0;
    my $two   = lookahead( $pos + 2, $sum ) ;
    my $three = lookahead( $pos + 3, $sum ) ;
    return $two > $three ? $two : $three ;
}

