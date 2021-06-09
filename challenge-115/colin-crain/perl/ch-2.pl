#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       list-one-perl-two.pl
# 
#       Largest Multiple
#         Submitted by: Mohammad S Anwar
#         You are given a list of positive integers (0-9), single digit.
# 
#         Write a script to find the largest multiple of 2 
#         that can be formed from the list.
# 
#         Examples
#         Input: @N = (1, 0, 2, 6)
#         Output: 6210
# 
#         Input: @N = (1, 4, 2, 8)
#         Output: 8412
# 
#         Input: @N = (4, 1, 7, 6)
#         Output: 7614
#
#         method:
#             sort the list 
#             iterate from small end:
#                 element %% 2 ? splice and small end move to end, last 
#                              : next
#             join list
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my @arr = @ARGV;
scalar @arr == 0 and @arr = ( 1, 0, 2, 6);

say largest_two(\@arr);


sub largest_two ($arr, $i = 0) {
    @arr = sort {$a-$b} @$arr;
    for (@arr) {
        if ($arr[$i] % 2 == 0) {
            unshift @arr, splice @arr, $i, 1;
            last;
        }
        $i++;
    }

    return $i < @arr ?  join '', reverse @arr 
                     :  "none" ;
}



use Test::More;

is largest_two( [1, 0, 2, 6] ), 6210, 'ex-1';
is largest_two( [1, 4, 2, 8] ), 8412, 'ex-2';
is largest_two( [4, 1, 7, 6] ), 7614, 'ex-3';
is largest_two( [3, 1, 3, 3] ),           "none", 'no multiple';
is largest_two( [3, 1, 7, 3, 5, 1, 8] ), 7533118, 'work for it';


done_testing();
