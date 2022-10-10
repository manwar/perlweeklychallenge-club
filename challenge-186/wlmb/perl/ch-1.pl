#!/usr/bin/env perl
# Perl weekly challenge 186
# Task 1:  Zip List
#
# See https://wlmb.github.io/2022/10/10/PWC186/#task-1-zip-list
use v5.36;
sub zip :prototype(\@\@) ($x,$y){
    my @result;
    while(@$x or @$y){ # Until both lists are exhausted
        push @result, shift @$x, shift @$y
    }
    grep {defined} @result  # remove undef's
}
die qq/Usage: $0 "x1 x2..." "y1 y2..."\nto zip two lists/ unless @ARGV==2;
my @x=split " ", shift;
my @y=split " ", shift;
say join " ", zip(@x, @y);
