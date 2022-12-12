#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       this-will-be-the-last-time.pl
#
#       Digital Clock
#         Submitted by: Mohammad S Anwar
#         You are given time in the format hh:mm with one missing digit.
# 
#         Write a script to find the highest digit between 0-9 that makes
#         it valid time.
# 
#         Example 1
#             Input: $time = '?5:00'
#             Output: 1
#     
#             Since 05:00 and 15:00 are valid time and no other digits can fit
#             in the missing place.
# 
#         Example 2
#             Input: $time = '?3:00'
#             Output: 2
# 
#         Example 3
#             Input: $time = '1?:00'
#             Output: 9
# 
#         Example 4
#             Input: $time = '2?:00'
#             Output: 3
# 
#         Example 5
#             Input: $time = '12:?5'
#             Output: 5
# 
#         Example 6
#             Input: $time =  '12:5?'
#             Output: 9
# 
#         method:
# 
#             there are only four positions that the missing digit can
#             occupy, and a total of only six cases to determine all
#             possible maximal digits.
# 
#                 1. in the leftmost position, the tens of hours, the
#                    maximal value is 1 — unless the second position is less
#                    than 4, in which case it is 2.
# 
#                 2. in the lesser hours place, the largest value is 9,
#                    with an exception when the larger position is 2, in
#                    which case it is 3.
# 
#                 3. in the larger minutes place the maximum value will
#                    always be 5.
# 
#                 4. in the smaller minutes the largest value is 9.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub last_time ( $time ) {
## return the missing digit, substituted with '?', 
## to produce the maximal 24-hour timestamp

    $_ = index $time, '?';

    $_ == 0                                 ## tens of hours
        ? substr ($time, 1, 1) < 4 
            ? 2
            : 1
        : $_ == 1                           ## ones of hours
            ? substr ($time, 0, 1) == 2
                ? 3
                : 9
            : $_ == 3                       ## tens of minutes (after separator)
                ? 5
                : 9                         ## ones of minutes
}

use Test::More;

is last_time( '?5:00' ), 1, 'ex_1';
is last_time( '?3:00' ), 2, 'ex_2';
is last_time( '1?:00' ), 9, 'ex_3';
is last_time( '2?:00' ), 3, 'ex_4';
is last_time( '12:?5' ), 5, 'ex_5';
is last_time( '12:5?' ), 9, 'ex_6';

done_testing();
