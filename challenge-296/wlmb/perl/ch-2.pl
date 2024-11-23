#!/usr/bin/env perl
# Perl weekly challenge 296
# Task 2:  Matchstick Square
#
# See https://wlmb.github.io/2024/11/18/PWC296/#task-2-matchstick-square
use v5.36;
use List::Util qw(sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 L1 L2...
    to build a square by joining sticks of lengths L1, L2...
    FIN
my $side;
sub test(@l){
    my $sum = sum0(@l);
    return 0 if $sum %4; # fails if sum is not multiple of 4.
    $side = $sum/4;
    return test_aux(@l)
}
sub test_aux(@l){
    return 1 unless @l; # success if list is empty
    my $first = shift(@l);
    return 0 if $first > $side;
    return test_aux(@l) if $first == $side; # Matched one side, test the rest
    for(0..@l-1){ # join two sticks and test
	return 1 if test_aux($first + $l[$_], @l[0..$_-1,$_+1..@l-1])
    }
    return 0; # fail if joining any sticks to the first fails
}
say "@ARGV -> ", test(@ARGV)?"True":"False";
