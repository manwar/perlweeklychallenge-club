#!/usr/bin/env perl
# Perl weekly challenge 138
# Task 1: Workdays
#
# See https://wlmb.github.io/2021/11/09/PWC138/#task-1-workdays
use v5.12;
use warnings;
use integer;
my @workdays=([261, 261, 261, 261, 261, 260, 260],
              [262, 262, 262, 262, 261, 260, 261]);
foreach(@ARGV){
    my $first_weekday=(($_-1)+($_-1)/4-($_-1)/100+($_-1)/400)%7; # 0=Monday
    my $leap=$_%400==0||$_%4==0&&$_%100!=0;
    say "Year: $_ Workdays: $workdays[$leap][$first_weekday]"
}
