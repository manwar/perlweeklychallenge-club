#!/usr/bin/env perl
# Perl weekly challenge 136
# Task 1: Fibonacci sequence
#
# See https://wlmb.github.io/2021/10/25/PWC136/#task-2-fibonacci-sequence
use v5.12;
foreach(@ARGV){
    my $count=my @sequences=fib($_,1,1);
    say "Input: $_\nOutput: $count",
        $count?join "\n       =", "\nAs $_", map {join "+", @$_} @sequences
              :"";
}

sub fib {
    my ($number, $current, $previous)=@_;
    return
         $current>$number? ()
        :$current==$number? ([$current])
        :(
             fib($number,$current+$previous, $current),
             map {unshift @$_, $current; $_}
                 (fib($number-$current,$current+$previous, $current))
        );
}
