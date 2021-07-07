#!/usr/bin/env perl
# Perl weekly challenge 120
# Task 2: Clock angle
#
# See https://wlmb.github.io/2021/07/07/PWC220/#task-2-clock-angle
use strict;
use warnings;
use v5.12;

for(@ARGV){
    say "Wrong format: $_", next
         unless $_=~m/^(\d?\d):(\d\d)$/
                && 0<=$1<=24 && 0<=$1<60; # <24?
    my $angle=(30*($1+$2/60)-$2*6)%360;
    $angle=360-$angle if $angle>180;
    say "Input: $_, Output: $angle";
}
