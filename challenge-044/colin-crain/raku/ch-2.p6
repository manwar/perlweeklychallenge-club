use v6;

#
#       two_hundred.p6
#
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
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN (Int:D $target where { $target > 1 } = 200) {
    my $value = $target;
    my @steps = $value;

    while $value > 1 {
        $value -= $value %% 2 ?? $value / 2 !! 1;
        unshift @steps, $value;
    }

    say @steps.join: ", ";
}
