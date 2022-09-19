#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       a-little-off-the-bottom-please.pl
#
#         Trim List
#         Submitted by: Mohammad S Anwar
#         You are given list of numbers, @n and an integer $i.
# 
#         Write a script to trim the given list where element is less than
#         or equal to the given integer.
# 
#         Example 1
#             Input: @n = (1,4,2,3,5) and $i = 3
#             Output: (4,3,5)
# 
#         Example 2
#             Input: @n = (9,0,6,2,3,8,5) and $i = 4
#             Output: (9,6,8,5)
# 
# 
#       method:
#         am I missing something? This is what `grep` does.
# 
#         But for that to be true, then example 1 is wrong, and should not
#         include 3. The fact that the number of elements in both examples
#         is equal to the input $i must be a red herring, and conincidence.
# 
#         Right? 
#         
#         He says, with audible doubt in his voice.
# 
#         I'm leaning on the first example being wrong. That has to be it,
#         but it seems too easy. I think I may have trust issues.
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



sub trim_low ( $val, $arr ) { 
    return grep { $_ > $val } $arr->@*;
}



## some tests
say '( ', (join ', ', trim_low( 3, [1,4,2,3,5] )),     ' )';
say '( ', (join ', ', trim_low( 4, [9,0,6,2,3,8,5] )), ' )';
