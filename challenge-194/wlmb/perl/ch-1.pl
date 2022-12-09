#!/usr/bin/env perl
# Perl weekly challenge 194
# Task 1:  Digital Clock
#
# See https://wlmb.github.io/2022/12/05/PWC194/#task-1-digital-clock
use v5.36;
#Perl  @PerlWChallenge 194 Task 1:  Digital Clock

L: for my $in(@ARGV){
    for(reverse(0..9)){
        my $y=$in;
        $y=~s/\?/$_/;
        say("Wrong format $in"), next L unless $y=~/(\d\d):(\d\d)/;
        say("$in -> $_"), next L if $1<=23 and $2<=59
    }
    say "$in -> No solution";
}
