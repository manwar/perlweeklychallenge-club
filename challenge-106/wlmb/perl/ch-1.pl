#!/usr/bin/env perl
# Perl weekly challenge 106
# Task 1: Maximum gap
#
# See https://wlmb.github.io/2021/03/29/PWC106/#task-1-maximum-gap

use strict;
use warnings;
use v5.12;
use List::Util qw(reduce);

my @sorted=sort {$a<=>$b} @ARGV;
say +(reduce {$b>$a?$b:$a} map {$sorted[$_+1]-$sorted[$_]} 0..$#sorted-1)//0,
    join ' ', '<-(', @ARGV, ')',
