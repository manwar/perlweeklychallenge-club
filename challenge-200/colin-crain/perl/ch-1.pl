#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       arithmetic-sequences.pl
#
#       Arithmetic Slices
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers.
# 
#         Write a script to find out all Arithmetic Slices for the given
#         array of integers.
# 
#         An integer array is called arithmetic if it has at least 3
#         elements and the differences between any three consecutive
#         elements are the same.
# 
# 
#         Example 1
#             Input: @array = (1,2,3,4)
#             Output: (1,2,3), (2,3,4), (1,2,3,4)
# 
#         Example 2
#             Input: @array = (2)
#             Output: () as no slice found.
# 
#
#         method:
# 
#             we work from left to right. Starting at element [0], we look
#             ahead to element [1]. We set the $last difference as the
#             difference between elements [1] and [0]. We then look to
#             element 2. If the difference between it and [1] is the same
#             we have a sequence: store the slice between our starting and
#             ending positions as a nested array in @out.
# 
#             We then move through the rest of the array as long as the
#             difference between adjacent elements remains the same as the
#             last difference. If it is, again store the slice from the start to
#             current lookahead in @out as well.
# 
#             On failure move the start position up one and begin to search again.
# 
#             Stop two places from the end position, as that is the minimal space to
#             find a new sequence.
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my @arr = @ARGV;
@arr == 0 and @arr = (1,2,3,5,7,9,6,3,0,-3);

my @out;
my $last;
my $curr;

for (0..$#arr-2) {
    $curr = $_+1;
    $last = $arr[$_+1] - $arr[$_];
    while ($arr[$curr+1] - $arr[$curr] == $last) {
        push @out, [ @arr[$_..$curr+1] ];
        last if ++$curr == $#arr;
    }
}

say "$_->@*" for @out;




