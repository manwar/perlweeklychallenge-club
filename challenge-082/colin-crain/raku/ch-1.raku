#!/usr/bin/env perl6
# 
#
#       factor_hardly_knew_her.raku
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
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $M = 18, Int $N = 36) ;

my %bag = bag factor($M);
my @out = factor($N).unique
                    .sort
                    .grep: {%bag{$_}:exists};

say "input  :\n\tM = $M\n\tN = $N";
say "output : ", @out;

sub factor (Int $num) {
    gather {
        for (1..$num.sqrt.Int).grep({$num %% $_}) {            
            take $_;
            take $num div $_;
        }
    }
}
