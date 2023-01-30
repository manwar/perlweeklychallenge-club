#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       complemenary-my-dear-watson.pl
#
#       Missing Numbers
#         Submitted by: Mohammad S Anwar
#         You are given an array of unique numbers.
# 
#         Write a script to find out all missing numbers in the range 0..$n
#         where $n is the array size.
# 
#         Example 1
#             Input: @array = (0,1,3)
#             Output: 2
# 
#             The array size i.e. total element count is 3, 
#             so the range is 0..3.
#             The missing number is 2 in the given array.
# 
#         Example 2
#             Input: @array = (0,1)
#             Output: 2
# 
#             The array size is 2, therefore the range is 0..2.
#             The missing number is 2.
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my @in = @ARGV;
scalar @in == 0 and @in = (6,9,13,27);
my %lookup = map { $_, undef } @in;

my @out = grep { ! exists $lookup{$_} } ( 0..scalar @in );

say "@out";






