#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       that-cats-some-square.pl
#
#         Sum of Squares
#         Submitted by: Mohammad Meraj Zia
#         You are given a number $N >= 10.
# 
#         Write a script to find out if the given number $N is such that sum of
#         squares of all digits is a perfect square. Print 1 if it is otherwise
#         0.
# 
#         Example
#         Input: $N = 34
#         Ouput: 1 as 3^2 + 4^2 => 9 + 16 => 25 => 5^2
# 
#         Input: $N = 50
#         Output: 1 as 5^2 + 0^2 => 25 + 0 => 25 => 5^2
# 
#         Input: $N = 52
#         Output: 0 as 5^2 + 2^2 => 25 + 4 => 29
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( sum );

die "usage:\n ./that-cats-some-square.pl positive-integer \n" unless @ARGV && $ARGV[0] > 0;
my $num = $ARGV[0] ;

my $sum = sum map { $_ ** 2 } split //, $num;
(int(sqrt($sum)))**2 == $sum 
    ? say 1
    : say 0 ;














# use Test::More;
# 
# is 
# 
# done_testing();
