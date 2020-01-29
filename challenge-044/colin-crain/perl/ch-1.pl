#! /opt/local/bin/perl
#
#       one_hundred.pl
#
#         PWC 44 - TASK #1
#         Only 100, please.
#             You are given a string “123456789”. Write a script that would insert
#             ”+” or ”-” in between digits so that when you evaluate, the result
#             should be 100.
#
#          method:  For the list (1, 2, 3, 4, 5 , 6, 7, 8, 9) there are 9
#             elements, or 8 interelemental spacings for operators.
#
#             Each operator can be one of '+' '-' or '~', signifying merging the
#             two numbers into one number 10a+b
#
#             3 choices 8 times yields 3^8 permutations with repetition, or 6561
#             equations to be considered.

#             The 'merge' operator a~b is associative to itself,
#                 (1~2)~3 = 1~(2~3) = 123
#             however
#                 (1+2)~3 != 1+(2~3)
#             thus it has higher precedence than the others and must be evaluated
#             first. By concatenating a~b into the equation string during
#             construction as 'ab' this is practically accomplished positionally
#             rather than overtly mathematically, yet with the same result as applying
#                 f(a,b) = 10a+b
#
#             the resultant string, containing only left-associative operators can
#             now be eval'd left to right and compared to 100

#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my @list = ( 1..9 );
my @equations = shift @list;
my $idx = 0;

for my $new ( @list ){
    while (my $target = splice @equations, $idx, 1){
        for (' + ', ' - ', ''){
            splice @equations, $idx, 0, $target . $_ . $new;
            $idx++;
        }
    }
    $idx = 0;
}

## output#
for (@equations){
    printf "%-30s = 100\n", $_ if eval $_ == 100;
}
