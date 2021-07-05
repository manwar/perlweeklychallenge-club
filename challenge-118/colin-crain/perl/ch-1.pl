#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       bin-pal.pl
#
#       Binary Palindrome
#         Submitted by: Mohammad S Anwar
#         You are given a positive integer $N.
# 
#         Write a script to find out if the binary representation of the given
#         integer is Palindrome. Print 1 if it is otherwise 0.
# 
#         Example
#         Input: $N = 5
#         Output: 1 as binary representation of 5 is 101 which is Palindrome.
# 
#         Input: $N = 4
#         Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.
# 
#       method:
#         since we are tasked to determine a boolean result for a single value, 
#         we can simply convert the number to a binary string representation
#         and assess that for palindromicity. 
# 
#         Palindromity. 
# 
#         Palinodromacity. 
#         
#         "Internal vertical-axis symmetry with respect to character-unit labels."
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $num = shift @ARGV || 153;

$_ = sprintf "%b", $num;
 
m/^(.+).?(??{reverse($1)})$/ 
    ? say 1
    : say 0 ;










