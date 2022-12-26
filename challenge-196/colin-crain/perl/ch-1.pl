#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       room-132.pl
#
#       Pattern 132
#         Submitted by: Mohammad S Anwar
#         You are given a list of integers, @list.
# 
#         Write a script to find out subsequence that respect Pattern 132.
#         Return empty array if none found.
# 
#         Pattern 132 in a sequence (a[i], a[j], a[k]) such that 
#         i < j < k and a[i] < a[k] < a[j].
# 
#         Example 1
#             Input:  @list = (3, 1, 4, 2)
#             Output: (1, 4, 2) respect the Pattern 132.
#             
#         Example 2
#             Input: @list = (1, 2, 3, 4)
#             Output: () since no susbsequence can be found.
# 
#         Example 3
#             Input: @list = (1, 3, 2, 4, 6, 5)
#             Output: (1, 3, 2) if more than one subsequence found then return the first.
# 
#         Example 4
#             Input: @list = (1, 3, 4, 2)
#             Output: (1, 3, 2)
# 
#       method
# 
#         rearranging the pattern, I think it will be easier to search
#         backwards from the third element instead of looking ahead from
#         the first. Which means we can iterate across the input array
#         starting at the third elemnet, then, backtracking to the first,
#         find the first element less than the value at the start, and then
#         continue closing from that point forward intil we are back to the
#         start position, looking for a value greater than the start. If we
#         find both other elements we will have found the leftmost match of
#         the pattern. 
        
        
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


my @array = (1, 3, 4, 2);
my @match;
my ($first, $second, $third);

OUTER: for my $start (2..$#array) {
    for my $idx (0..$start-1) {
        $first = $array[$idx] if $array[$idx] < $array[$start];
        if (defined($first) && ($array[$idx] > $array[$start])) {
            @match = ($first, $array[$idx], $array[$start]);
            last OUTER;
        }
    }
    undef $first; 
}

print '(', (join ', ', @match), ')';





