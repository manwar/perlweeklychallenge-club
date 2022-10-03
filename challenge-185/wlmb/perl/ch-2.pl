#!/usr/bin/env perl
# Perl weekly challenge 185
# Task 2:  Mask Code
#
# See https://wlmb.github.io/2022/10/03/PWC185/#task-2-mask-code
use v5.36;
for(@ARGV){
    my $n=0;
    say "$_ -> ", join "", map {$n<4 && ($n+=s/[A-Za-z0-9]/x/); $_} split ""
}
