#!/usr/bin/env perl

# Challenge 044
#
# TASK #1
# Only 100, please.
# You are given a string “123456789”. Write a script that would insert
# “+” or "-" in between digits so that when you evaluate, the result should
# be 100.

use Modern::Perl;

for my $a ('', '-', '+') {
    for my $b ('', '-', '+') {
        for my $c ('', '-', '+') {
            for my $d ('', '-', '+') {
                for my $e ('', '-', '+') {
                    for my $f ('', '-', '+') {
                        for my $g ('', '-', '+') {
                            for my $h ('', '-', '+') {
                                my $test = "1${a}2${b}3${c}4${d}5${e}6${f}7${g}8${h}9";
                                my $res = eval $test;
                                if ($res==100) {
                                    say $test;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
