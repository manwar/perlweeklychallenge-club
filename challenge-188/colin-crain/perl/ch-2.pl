#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       noise-is-for-heros-musics-for-zeros.pl
#
#       Total Zero
#         Submitted by: Mohammad S Anwar
#         You are given two positive integers $x and $y.
# 
#         Write a script to find out the number of operations needed to
#         make both ZERO. Each operation is made up either of the
#         followings:
# 
#         $x = $x - $y if $x >= $y
# 
#         or
# 
#         $y = $y - $x if $y >= $x (using the original value of $x)

#         Example 1
#             Input: $x = 5, $y = 4
#             Output: 5

#         Example 2
#             Input: $x = 4, $y = 6
#             Output: 3

#         Example 3
#             Input: $x = 2, $y = 5
#             Output: 4

#         Example 4
#             Input: $x = 3, $y = 1
#             Output: 3

#         Example 5
#             Input: $x = 7, $y = 4
#             Output: 5

#         analysis:
# 
#             As is often the case decoding the description is part of the
#             challenge. In example 4, with x = 3 and y = 1, the first op
#             is to subtract y from x, producing a new value of 2 for x.
#             THis is repeated on the next cycle, yielding a count of 2 and
#             a new x of 1. In the third cycle x is equal to y and so we
#             have x = x - y a third time, but also y is equal to the value
#             of x going in, so y = y - x and both are set to 0.
#             Tprogression concludes in three cycles, but was that three or
#             four operations? Fo you feel lucky, punk?
# 
#             I think the correct phrasing to produce the example output is
#             not: "Each operation is made up either of the followings...",
#             but rather: "Each operation is made up ONE OR BOTH of the
#             following manipulations..."
# 
#             In this way should the two values be equal, each can be
#             subtracted from the other, zeroing the output in a single
#             operation. 

#             Always counting the two actions completely separately
#             produces a cyclic non-resolving pattern as once either value
#             goes to zero subtracting this from the other value no longer
#             changes the result. So that will never work.
# 
#             Maintaining the idea of the previous x across cycles is
#             problematic but not impossible: we save out x if x changes,
#             but always use the saved value to compare y. This however
#             does not give the values from the examples, counting an extra
#             step to reduce the other value to zero and equilibrium.
# 
#             This was my reasoning to get the examples to work right. I
#             can't wait to see what the others have done.
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



sub count_to_zero ( $x, $y, $count = 0 ) {    
    while ( ($x != 0 and $y != 0)  and ++$count ) {
        my $prev_x = $x;
        $x >= $y      and $x -= $y;
        $y >= $prev_x and $y -= $prev_x;
    }
    return $count;
}



use Test::More;

is count_to_zero( 5, 4), 5, 'ex-1';
is count_to_zero( 4, 6), 3, 'ex-2';
is count_to_zero( 2, 5), 4, 'ex-3';
is count_to_zero( 3, 1), 3, 'ex-4';
is count_to_zero( 7, 4), 5, 'ex-5';

done_testing();
