#! /opt/local/bin/perl
#
#       factor_hardly_knew_her.pl
#
#         TASK #1 › Common Factors
#         Submitted by: Niels van Dijke
#             You are given 2 positive numbers $M and $N.
# 
#             Write a script to list all common factors of the given numbers.
# 
#         Example 1:
#             Input:
#                 $M = 12
#                 $N = 18
# 
#             Output:
#                 (1, 2, 3, 6)
# 
#             Explanation:
#                 Factors of 12: 1, 2, 3, 4, 6
#                 Factors of 18: 1, 2, 3, 6, 9
# 
#         Example 2:
#             Input:
#                 $M = 18
#                 $N = 23
# 
#             Output:
#                 (1)
# 
#             Explanation:
#                 Factors of 18: 1, 2, 3, 6, 9
#                 Factors of 23: 1
# 
#         method:
#             When a number is said to be a factor of another number, the
#             meaning is that number times another number will equal the third.
#             Reciprocally, both the number tested and the multiplier are both
#             factors of third.
# 
#             As such when factoring, we need only check for numbers up to the
#             square root of our target, if, when we find a pair of numbers that
#             fit, we log both to out result list.
# 
#             Once we have the factors for one of our numbers, the best way to
#             determine the common elements between two arrays (when we don't
#             care about duplicates) is to use a hash. The factors of the first
#             input number are hashed and the the sorted list of factors for the
#             second number are filtered for presence in the hash before being
#             output.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my $M = shift || 1440;
my $N = shift || 1530;

my %lookup = map { $_ => undef } factor($M);
my @out = grep { exists $lookup{$_} } sort {$a-$b} factor($N);

say "input :\n\tN = $N\n\tM = $M";
say "output: ( @out )";


## ## ## ## ## SUBS:

sub factor {
    my $num = shift;
    my @out;
    my $sq = int sqrt $num;
    for (1..$sq) {
        if ($num % $_ == 0) { 
            push @out, $_;
            push @out, $num / $_ unless $_**2 == $num;   
        }
    }
    return @out;
}