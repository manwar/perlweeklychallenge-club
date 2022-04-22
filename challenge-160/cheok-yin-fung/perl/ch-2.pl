#!/usr/bin/perl
# The Weekly Challenge 160
# Task 2 Equilibrium Index
# Post-Deadline Modification
# see https://e7-87-83.github.io/coding/challenge_160.html
# or
# https://e7-87-83.github.io/code/ch-2-wk160-positive.pl
# Tuesday, April 19, 2022 AM01:12:42 HKT

use v5.22.0;
use warnings;
use List::Util qw/sum all/;


say ei(@ARGV) if defined($ARGV[0]);



sub ei {
    my @n = @_;
    my @trial = (undef) x scalar @n;
    $trial[0] = 1;
    $trial[$#n] = 1;
    my $ind = int $#n/2;
    my $new_ind = $ind;
    my $hint_lower = sum(@n[0..$ind-1]);
    my $hint_upper = sum(@n[$ind+1..$#n]);
    my $step = 0;
    my $expired_ind = $ind;

    my $success = $hint_lower == $hint_upper;
    return $ind if $success;

    while (!$success) {
        return -1 if all {$_} @trial;
        $trial[$ind] = 1;
        # say "LOWER: ", $hint_lower, "; MID: ", 
        #    $n[$ind], "($ind)", "; UPPER: ",$hint_upper,
        #    " ;   DIRECTION: ", $step;


        my $cur_val = $n[$ind];

        # Modify the two portions
        if ($step == +1) {
            $hint_lower = $hint_lower + $n[$expired_ind];
            $hint_upper = $hint_upper - $cur_val;
        }
        elsif ($step == -1) {
            $hint_lower = $hint_lower - $cur_val;
            $hint_upper = $hint_upper + $n[$expired_ind];
        }

        # Check whether we get an equilibrium index
        $success = $hint_lower == $hint_upper;
        return $ind if $success;

        # Decide which direction going to move
        $step = (int rand(2)) % 2 ? +1 : -1;

        # Prepare for the next loop block, or, stop
        $new_ind = $ind + $step;
        if ($new_ind == 0) {
            $step = +1;
            $new_ind = 2;
        }
        if ($new_ind == $#n) {
            $step = -1;
            $new_ind = $#n-2;
        }
        ($expired_ind, $ind) = ($ind, $new_ind);
    }
}



use Test::More tests=>50;
say "TESTING:";
my @n_temp;
for my $case (1..50) {
    $n_temp[$_] = 20 - int rand(40) for (0..31);
    my $i = ei(@n_temp);
    ok (
           ei_simple(@n_temp) == $i
                              ||
        sum(@n_temp[0..$i-1]) == sum(@n_temp[$i+1..$#n_temp])
    );
}
done_testing();



sub ei_simple {
    my @seq = @_;
    for (1..$#seq-1) {
        return $_ if sum(@seq[0..$_-1]) == sum(@seq[$_+1..$#seq]);
    }
    return -1;
}
