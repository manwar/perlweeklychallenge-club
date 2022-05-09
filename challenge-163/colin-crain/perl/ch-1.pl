#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       an-sumting-else.pl
#
#       Sum Bitwise Operator
#         Submitted by: Mohammad S Anwar
#         You are given list positive numbers, @n.
# 
#         Write script to calculate the sum of bitwise & operator for all unique pairs.
# 
#         Example 1
# 
#             Input: @n = (1, 2, 3)
#             Output: 3
#     
#             Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.
#     
#         Example 2
# 
#             Input: @n = (2, 3, 4)
#             Output: 2
#     
#             Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.
# 
#         opening commentary:
# 
#             Ahh, the old bitwise-AND n-choose-2! I was wondering when you
#             would show your face again around here again! I'm frankly a
#             little surprised after what happened last time. Things, if I
#             recall correctly, did not go well for you? Well, you'll need
#             to watch your back is all I'll say. Frank there, over in the
#             corner, has been drinking all day and the twins have been
#             hollarin' up a storm. I just want to let you know I don't
#             want no trouble, and don't want to see no trouble, so that's
#             what I'm going to do. You hear me right? Good. I'm glad we
#             had this talk.
# 
#         analysis:
# 
#             I feel I might need to do some research and try and figure
#             out if this particular process has any practical use. Nothing
#             immediately comes to mind, but that doesn't mean I haven't
#             missed anything. I enjoy finding things I don't know in
#             general. Perhaps this is one of those things. Assuming
#             there's something to know.
# 
#             The operation specified is akin to the cartesian-product of a
#             set with itself, or the dot product in a way, with more
#             parts, or perhaps, well, I'm not quite sure what. What we are
#             doing, though, is to collect all 2-combinations from the set
#             of list elements and apply a bitwise AND operation to each
#             pair, and then sum the resulting values. If there's a name
#             for this type of operation I don't know it.
# 
#         method:
# 
#             We can obtain a set of unique pairings between items is a
#             set, excluding any identity pairings, by using two indexes in
#             two loops, with the second index keyed one-advanced from the
#             first. The interior of this structure will have both indexes
#             available and we can examine the list at these positions and
#             apply the bitwise operation. The result is added to an
#             accumulator which is ultimately returned.
# 
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

use constant {TEST => 1};

@ARGV == 0 
? say "please input a space-separated list of values at command line\n" 
: say and_sum( @ARGV );


sub and_sum (@list) {
    my $sum;
    for my $i (0..$#list-1) {
        for my $j ($i+1..$#list) {
            $sum += $list[$i] & $list[$j];
        }
    }
    return $sum;
}


exit unless TEST;

use Test::More;

is and_sum(1, 2, 3), 3, 'ex-1';
is and_sum(2, 3, 4), 2, 'ex-2';

done_testing();
