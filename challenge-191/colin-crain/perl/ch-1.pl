#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       twice_as_big_as_me.pl
#
#       Twice Largest
#         Submitted by: Mohammad S Anwar
#         You are given list of integers, @list.
# 
#         Write a script to find out whether the largest item in the list
#         is at least twice as large as each of the other items.
# 
#         Example 1
#             Input: @list = (1,2,3,4)
#             Output: -1
# 
#             The largest in the given list is 4. However 4 is not greater
#             than twice of every remaining elements.
#             1 x 2 <= 4
#             2 x 2 <= 4
#             2 x 3 >  4
#     
#         Example 2
#             Input: @list = (1,2,0,5)
#             Output: 1
# 
#             The largest in the given list is 5. Also 5 is greater than
#             twice of every remaining elements.
#             1 x 2 <= 5
#             2 x 2 <= 5
#             0 x 2 <= 5
#     
#         Example 3
#             Input: @list = (2,6,3,1)
#             Output: 1
# 
#             The largest in the given list is 6. Also 6 is greater than
#             twice of every remaining elements.
#             2 x 2 <= 6
#             3 x 2 <= 6
#             1 x 2 <= 6
#     
#         Example 4
#             Input: @list = (4,5,2,3)
#             Output: -1
# 
#             The largest in the given list is 5. Also 5 is not greater
#             than twice of every remaining elements.
#             4 x 2 >  5
#             2 x 2 <= 5
#             3 x 2 >  5
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


sub twice_as_big_as_me ( @list ) {
    return -1 if @list == 0;
    return 1  if @list == 1;
    
    my ($largest, $second) = splice @list, 0, 2;
    ($largest, $second) = ($second, $largest) if $second > $largest;
    my $twice = $largest >= 2 * $second ? 1 : -1;
    
    for (@list) {
        if ( $_ > $largest ) {
            $second = $largest;
            $largest = $_;
            $twice = ($largest >= 2 * $second) ? 1 : -1;
        }
    }
 
    return $twice;
}



use Test::More;

is twice_as_big_as_me(1,2,3,4), -1, 'ex-1';
is twice_as_big_as_me(1,2,0,5),  1, 'ex-2';
is twice_as_big_as_me(2,6,3,1),  1, 'ex-3';
is twice_as_big_as_me(4,5,2,3), -1, 'ex-4';

done_testing();
