#!/usr/bin/perl
# The Weekly Challenge 160
# Task 2 Equilibrium Index
use v5.22.0;
use warnings;
use List::Util qw/sum/;


say ei(@ARGV) if defined($ARGV[0]);



sub ei {
    my @n = @_;
    my $ind = int $#n/2;
    my $previous_ind = $ind;
    my $new_ind = $ind;
    my $hint_lower = sum(@n[0..$ind-1]);
    my $hint_upper = sum(@n[$ind+1..$#n]);
    my $step = 0;
    my $expired_ind = $ind;
    my $guessed_step = 0;

    my $success = $hint_lower == $hint_upper;
    return $ind if $success;
    

    while (!$success) {
        return -1 if $ind < 1 or $ind > $#n-1;

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


        # Decide which direction going to move
        if ($hint_lower+$cur_val < $hint_upper) {
            $new_ind = $ind+1;
        }
        elsif ($hint_lower > $hint_upper+$cur_val) {
            $new_ind = $ind-1;
        }
        elsif ($hint_lower+$cur_val == $hint_upper) {
            $new_ind = $ind+$step;
        }
        elsif ($hint_lower == $hint_upper+$cur_val) {
            $new_ind = $ind+$step;
        }

        else {    
            if ($hint_lower+$cur_val > $hint_upper) {
                if ($hint_lower+$cur_val >= $hint_upper-$n[$ind+1]) {
                    $new_ind = $ind+1;
                }
                else {
                    $new_ind = $ind-1;
                }
            }
            if ($hint_lower < $hint_upper+$cur_val) {
                $new_ind = $ind-1;
            }

            if ($hint_lower == $hint_upper+$cur_val 
                            or 
                $hint_lower+$cur_val == $hint_upper)
            {
                $new_ind = $ind+$step; # follow the previous direction
            }
        }    

        # Prepare for the next loop block, or, stop
        $step = $new_ind-$ind;
        $success = $hint_lower == $hint_upper;
        return $ind if $success;
        return -1 if $guessed_step == -$step; # No back and fro!
        $guessed_step = $step;
        ($expired_ind, $ind) = ($ind, $new_ind);
    }
}



use Test::More tests=>50;
say "TESTING:";
my @n_temp;
for my $case (1..50) {
    $n_temp[$_] = 1 + int rand(40) for (0..31);
    ok ei_simple(@n_temp) == ei(@n_temp);
}
done_testing();



sub ei_simple {
    my @seq = @_;
    for (1..$#seq-1) {
        return $_ if sum(@seq[0..$_-1]) == sum(@seq[$_+1..$#seq]);
    }
    return -1;
}

