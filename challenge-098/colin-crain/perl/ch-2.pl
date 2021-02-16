#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       know-your-place.pl
#
#         TASK #2 › Search Insert Position
#         Submitted by: Mohammad S Anwar
#         You are given a sorted array of distinct integers @N and a target $N.
# 
#         Write a script to return the index of the given target if found
#         otherwise place the target in the sorted array and return the index.
# 
#         Example 1:
#             Input: @N = (1, 2, 3, 4) and $N = 3
#             Output: 2 since the target 3 is in the array at the index 2.
# 
#         Example 2:
#             Input: @N = (1, 3, 5, 7) and $N = 6
#             Output: 3 since the target 6 is missing and should be placed at the index 3.
# 
#         Example 3:
#             Input: @N = (12, 14, 16, 18) and $N = 10
#             Output: 0 since the target 10 is missing and should be placed at the index 0.
# 
#         Example 4:
#             Input: @N = (11, 13, 15, 17) and $N = 19
#             Output: 4 since the target 19 is missing and should be placed at the index 4.
#
# 
#         method:
#             We could take a naive approach — a brute force assault of the
#             citadel, boldly running the gauntlet through the front door up to
#             the insert point, but we can do better. We can be sneaky and
#             improve our idea of where we're going with every step we take. If
#             we by start in the middle and successively subdivide the remaining
#             range, we can home in on the correct placement.

#             This method is a version of a binary search: we start off knowing
#             that the correct location, whatever that may be, lies within the
#             bounds of the array after the new element has been added. I mean,
#             it might be tautologically obvious that after the element has been
#             added, it will be held at some position within the array, but you
#             have to start somewhere. We know, thus, before we start that the
#             lower bound for the correct placement is 0, and the upper bound is
#             the length of starting array plus one, for the new element. The
#             known range is quite broad at this point, but through a series of
#             actions we can refine it until there is only one position left,
#             which is the correct place to insert the new element.
# 
#             We start by looking to add the element at the half-way point. At
#             every trial, first we see whether the index we're examining is the
#             value we're inserting. If it is, we've found the placement and
#             we're done.
# 
#             In the more-likely chance it's not equal, the value will either
#             greater than or less than that at the position. Again, stands to
#             reason. And with that calculation we've learned some new
#             information: for example, if the value is greater, than the
#             correct location cannot be less than that index. We can now adjust
#             our boundaries; the lower limit can be moved upwards to our mark.
#             We can also reset it to be one greater than the checked postion,
#             as we know it doesn't lie there either. Likewise, if the value is
#             less, we move the pointer for the upper bound to be the index one
#             less than the one tried.
# 
#             We've now constricted the known range for the correct insert index
#             by one-half. Not bad. We can continue to do this repeatedly, at
#             each pass redefining the available range for the result, until
#             either we land on an existing element with the value or the the
#             value at the index one below is less and the value at the index is
#             greater. If this is the case then we have located to correctly
#             sorted location for the new element.
# 
#             Because the directives say to insert the element into the list,
#             we'll take the list in as an array reference, then apply the
#             splice to the referenced list once we've found the insert point.
#             If the element is already there we'll of course leave things be.
#             In any case the list is altered in-place and the position of the
#             new element is returned
#             
#             
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.32";

sub insert {
    my ($num, $arr) = @_;
    $num > $arr->[-1] and do { push $arr->@*, $num;    return $#$arr };
    $num < $arr->[0]  and do { unshift $arr->@*, $num; return 0 };

    my $lower = 0;
    my $upper = $#$arr;
    while ( $lower <= $upper ) {
        my $pos = int( ($lower+$upper)/2 );                 ## midpoint

        return $pos if $arr->[$pos] == $num;
        if ($arr->[$pos-1] < $num < $arr->[$pos]) {
            splice( $arr->@*, $pos, 0, $num );  
            return $pos;
        }

        $arr->[$pos] > $num ? ($upper = $pos-1)             ## restrict the range
                            : ($lower = $pos+1);
    }
    
}



use Test::More;

is insert( 3,  [1, 2, 3, 4]     ), 2, 'ex-1, exists already';
is insert( 6,  [1, 3, 5, 7]     ), 3, 'ex-2, insert into middle';
is insert( 10, [12, 14, 16, 18] ), 0, 'ex-3, less than first';
is insert( 19, [11, 13, 15, 17] ), 4, 'ex-4, more than last';

for my $n (1..13) {
    $n = 500 - 37*$n;
    is insert( $n, [1..500] ), $n-1, "long list: target -> $n";
}
 
is insert( 1,  [2, 4, 6, 8]     ), 0, 'insert into idx 0';
is insert( 3,  [2, 4, 6, 8]     ), 1, 'insert into idx 1';
is insert( 5,  [2, 4, 6, 8]     ), 2, 'insert into idx 2';
is insert( 7,  [2, 4, 6, 8]     ), 3, 'insert into idx 3';
is insert( 9,  [2, 4, 6, 8]     ), 4, 'insert into idx 4';

is insert( 2,  [2, 4, 6, 8]     ), 0, 'match idx 0';
is insert( 4,  [2, 4, 6, 8]     ), 1, 'match idx 1';
is insert( 6,  [2, 4, 6, 8]     ), 2, 'match idx 2';
is insert( 8,  [2, 4, 6, 8]     ), 3, 'match idx 3';

done_testing();
