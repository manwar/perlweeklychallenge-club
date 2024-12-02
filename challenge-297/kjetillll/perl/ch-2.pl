#https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
use strict; use warnings; use List::Util 'max'; use Test::More tests => 5;

sub min_swaps {
    my %pos; @pos{@_} = 0 .. $#_;          #register positions for each number 1 - N
    my $swaps_to_move_1 = $pos{1};         #swaps needed to move 1 to first place
    my $swaps_to_move_N = $#_ - $pos{@_};  #swaps needed to move N to last place, N = @_
    my $discount_for_already_swapped_1_and_N = $pos{1} > $pos{@_} ? -1 : 0; #...while moving 1
    return $swaps_to_move_1 + $swaps_to_move_N + $discount_for_already_swapped_1_and_N #add up
}

for my $test (
    [2, 1, 4, 3 => 2 ],
    [2, 4, 1, 3 => 3 ],
    [1, 3, 2, 4, 5 => 0 ],
    [22,24,10,34,35,8,13,21,30,6,3,29,17,12,16,4,19,40,15,9,18,28,14,23,31,2,33,27,36,20,26,39,11,25,1,32,37,7,5,38 => 55],
    [17,26,31,5,12,9,6,24,35,29,21,22,1,20,33,15,2,28,38,34,25,30,16,27,36,7,37,19,32,40,4,3,8,10,23,14,11,39,13,18 => 22],
){
    my $expected = pop @$test;
    my @input = @$test;
    my $got = min_swaps(@input);
    is $got, $expected;
}
