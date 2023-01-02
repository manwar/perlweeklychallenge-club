#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       move-zero.pl
#
#       Move Zero
#         Submitted by: Mohammad S Anwar
# 
#         You are given a list of integers, @list.
# 
#         Write a script to move all zero, if exists, to the end while
#         maintaining the relative order of non-zero elements.
# 
# 
#         Example 1
#             Input:  @list = (1, 0, 3, 0, 0, 5)
#             Output: (1, 3, 5, 0, 0, 0)
# 
#         Example 2
#             Input: @list = (1, 6, 4)
#             Output: (1, 6, 4)
# 
#         Example 3
#             Input: @list = (0, 1, 0, 2, 0
#             Output: (1, 2, 0, 0, 0)
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my @input = (1,0,0,4,5,0,7);
say "input:  @input";


my $idx;
my $limit = $#input;

while (++$idx < $limit) {
    if ($input[$idx] == 0) {
        push @input, (splice @input, $idx, 1); 
        $idx--;
        $limit--;
    }    
}

say "output: @input";






