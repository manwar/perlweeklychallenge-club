#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       what-are-the-odds.pl
#
#       Consecutive Odds
#         Submitted by: Mohammad S Anwar
#         You are given an array of integers.
# 
#         Write a script to print 1 if there are THREE consecutive odds in
#         the given array otherwise print 0.
# 
# 
#         Example 1
#             Input: @array = (1,5,3,6)
#             Output: 1
# 
#         Example 2
#             Input: @array = (2,6,3,5)
#             Output: 0
# 
#         Example 3
#             Input: @array = (1,2,3,4)
#             Output: 0
# 
#         Example 4
#             Input: @array = (2,3,5,7)
#             Output: 1

#         method:
# 
#         we're going to try iterating by index acroos the input array, but
#         every time we get to and even digit we set the position counter
#         back to the beginning and shift off the offending digit.
# 
#         If we succeed in counting to 2, the third position in the array,
#         we will have found three consecutive odd digits without
#         restarting the count. We jump out of the loop and win.
# 
#         If we get to the end of the loop without counting to 2 (0-based,
#         the third index) then we fail
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
say odd_triplets( @arr ) if @arr;

sub odd_triplets ( @arr ) {
    my $pos = 0;
    while ($pos <= $#arr) {
        $arr[$pos] % 2 or do { $pos = -1; shift @arr };
        $pos++;
        last if $pos == 3;
    }

    return $pos == 3    
        ?  1
        :  0 ;
}









use Test::More;

is odd_triplets(1,5,3,6),     1, 'ex-1, front';
is odd_triplets(2,6,3,5),     0, 'ex-2, only 2';
is odd_triplets(1,2,3,4),     0, 'ex-3, only 2, separated';
is odd_triplets(2,3,5,7),     1, 'ex-4, tail';
is odd_triplets(1,2,3,5),     0, '3 but separated';
is odd_triplets(1,3,5,4,6,8), 1, 'head';
is odd_triplets(1,2,5,7,9,8), 1, 'mid';

done_testing();
