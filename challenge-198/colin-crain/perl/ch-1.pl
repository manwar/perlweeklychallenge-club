#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Max Gap
#         Submitted by: Mohammad S Anwar
#         You are given a list of integers, @list.
# 
#         Write a script to find the total pairs in the sorted list where 2
#         consecutive elements has the max gap. If the list contains less then
#         2 elements then return 0.
# 
# 
#     Example 1
#         Input:  @list = (2,5,8,1)
#         Output: 2
# 
#         Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
# 
#     Example 2
#         Input: @list = (3)
#         Output: 0
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


my @input = scalar @ARGV 
    ? @ARGV
    : (2,5,8,1) ;
    
say "input:  @input";
say "output: 0" and exit if scalar @input < 2;    

my @max;
my $span = 0;

for (0..$#input-1) {
    if ($input[$_+1] - $input[$_] > $span) {
        $span = $input[$_+1] - $input[$_];
        @max  = [$input[$_], $input[$_+1]];
    }
    elsif ($input[$_+1] - $input[$_] == $span) {
        push @max, [$input[$_], $input[$_+1]];
    }
}

local $" = ',';
say "output: ", join ', ', map { "($_->@*)" } @max;














# use Test::More;
# 
# is 
# 
# done_testing();
