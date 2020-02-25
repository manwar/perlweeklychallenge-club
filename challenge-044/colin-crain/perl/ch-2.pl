#! /opt/local/bin/perl
#
#       two_hundred.pl
#
#       PWC 44 - TASK #2
#       Make it $200
#             You have only $1 left at the start of the week. You have been given an
#             opportunity to make it $200. The rule is simple with every move you can either
#             double what you have or add another $1. Write a script to help you get $200 with
#             the smallest number of moves.


#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN


#     method: Of the two given options available to proceed towards our goal,
#
#                 f(x) = 2x
#                 g(x) = x + 1
#
#         given that
#
#             2x >= x+1 ∀ x > 0
#             --> goal - (2 * value) <= goal - (value + 1) ∀ x > 0 ,
#
#         doubling will invariably be a more efficiant progress towards the
#         goal, so f(x) should always be the preferred move. What is not obvious
#         is when to increment by 1. This becomes clear when we work backwards.
#         The way to find the optimum path is to invert the problem, working
#         backwards from the goal, either halving if even or subtracting one
#         until 1 is reached. The two available functions then become:
#
#                 f'(x) = x / 2
#                 g'(x) = x - 1
#
#         When we look at the inverted functions, we notice that any odd number
#         minus 1 becomes even, and hence able to be halved, which should always
#         be the preferred move. So any application of g'(x) is followed by
#         f'(x) for all x > 0. It is now clear the only application of g'(x)
#         will be to make x even again, allowing further application of f'(x).
#
#         Thus progressing from the end of the sequence, then reversing the
#         order of steps taken, both maximizes the use of the doubling function
#         and minimizes the addition, so any other variation will be
#         sub-optimal.
#
#         The resultant algorithm is:
#
#             reverse steps:
#                 x :- endpoint
#                 loop: until x = 1 {
#                     if x even -> halve x
#                     else x := x - 1
#                 }
#





my $value = shift @ARGV // 200;
my @steps = $value;

while ( $value != 1) {
    if ($value % 2 == 0){
        $value /= 2;
    }
    else {
        $value -= 1;
    }
    unshift @steps, $value;         ## we build the array of steps from back to front
                                    ## so there is no need to reverse it later
}

print join ', ', @steps;
