#!/usr/bin/env perl6
#
#
#       stroboscope.raku
#
#         TASK #1 › Strobogrammatic Number
#         Submitted by: Mohammad S Anwar
#             A strobogrammatic number is a number that looks the same
#             when looked at upside down.
#
#             You are given two positive numbers $A and $B such that
#                 1 <= $A <= $B <= 10^15.
#
#             Write a script to print all strobogrammatic numbers
#             between the given two numbers.
#
#         Example
#             Input:  $A = 50, $B = 100
#             Output: 69, 88, 96
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



sub MAIN (Int $A = 96, Int $B = 100001) {

    my $order  = ($B.chars/2).Int;    ## numbers up to 10^(2*$order+1) are generated

    my @list   = 0, 1, 6, 8, 9;
    my @center = 0, 1, 8;

    my @num    = @list.tail(*-1);     ## remove leading 0       ## thanks, Liz!
    my @stereo = @center;             ## ensures trivial single digit cases

    for ^$order {
        my @evens = Empty;
        my @odds  = Empty;   ## reset holding arrays

        for @num -> $left {
            my $right = $left.trans( '69' => '96' ).flip;
               @evens.push: ($left, $right).join;

            for @center -> $c {
                @odds.push: ($left, $right).join: "$c";
            }
        }
        @stereo.append: @evens;
        @stereo.append: @odds;

        ## add another digit to the working list
        @num = [X~] @num, @list;
    }

    for @stereo {
        next when $_ < $A;
        last when $_ > $B;
        .say;
    }
}
