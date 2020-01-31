#!/usr/bin/perl6
use v6;

use Test;


=begin pod

Task 1

Only 100, please.
You are given a string “123456789”. Write a script that would insert ”+” or ”-” in between digits so that when you evaluate, the result should be 100.

=end pod

sub MAIN(Str $number="123456789", Int :$target=100, Bool :$verbose=False, Bool :$all=False){
    # try base 8 digits of base 3
    # 0=nothing
    # 1=+
    # 2=-
    my Int $bal = 1;
    my $solution="";
    my $bits=($number.chars-1); # possible permutations
    my $fail=True;

    # EVAL was too slow so let's use an accumulator and operand to avoid it.
    for 3..^(3**$bits) -> Int $i {
        # accumulator
        my Int $acc=0;
        # initial
        my $operand =$number.substr(0,1); # Prime with first digit
        # operator is +1 for add or -1 for subtract
        my Int $operator = 1; # we start off adding the operand to 0 so set to +1

        my Int $j=$i;
        my @sum = $number.comb;

        # for visualisation of answer
        my Str $solution="1";
        # compose the sum
        for 1..$bits -> $index {
            my $k = $j % 3;
            if $k== 0 {
                $operand ~=@sum[$index];
                $solution~=@sum[$index];
            } elsif $k==1 {
                $acc=$acc+($operand*$operator);
                $operator = 1;
                $operand=@sum[$index];
                $solution~="+" ~ @sum[$index];
            } elsif $k==2 {
                $acc=$acc+($operand*$operator);
                $operator = -1;
                $operand=@sum[$index];
                $solution~="-" ~ @sum[$index];
            }

            $j=$j div 3;
        }
        # flush remaining ops
        $acc=$acc+($operand*$operator);
        # Answer is in the accumulator
        # visual answer is in $solution
        say "$i) checking $solution = "~ $acc if $verbose && $i %% 100;
        if $target == $acc {
            say "$number -> $solution = {$target} (Checked $i of {3**$bits-3} potential solutions)";
            $fail=False;
            exit unless $all;
        }
    }

    say "No solution found for $number targeting $target" if $fail;

}
