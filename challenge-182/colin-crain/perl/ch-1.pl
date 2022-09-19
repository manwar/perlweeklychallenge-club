#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       max-headroom.pl
#
#       Max Index
#         Submitted by: Mohammad S Anwar
#         You are given a list of integers.
# 
#         Write a script to find the index of the first biggest number in the list.
# 
#         Example
#         Input: @n = (5, 2, 9, 1, 7, 6)
#         Output: 2 (as 3rd element in the list is the biggest number)
# 
# 
#         Input: @n = (4, 2, 3, 1, 5, 0)
#         Output: 4 (as 5th element in the list is the biggest number)
# 
#       Analysis:
# 
#         One of those tasks that seems a lot harder than it works out to be. 
# 
#         This is cool excuse to use each on an array, where it returns a
#         key/value pair, only with an array the key is the index. One
#         interesting thing is that after loading the maximum value and
#         index with `each` for the assignment, the operator remembers the
#         state for the next time it is involked on the same array. So we
#         don't waste a cycle re-checking the index 0 and value pair.
# 
#         Unexpected and very interesting that `each` keeps an internal
#         iterator and can be invoked from several places. 
#         
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


my @arr = ( 5, 9, 7, 13, 7, 13 );       ## [3] is first largest
my ($max_idx, $max) = each @arr;        ## prime the pump

while (my ($i, $val) = each @arr) {     ## the first `each` grab is skipped. (cool!)
    ($max_idx, $max) = ($i, $val) if $val > $max;
}

say "array[$max_idx] = $max";
