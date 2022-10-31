#!/usr/bin/env perl
# Perl weekly challenge 189
# Task 1:  Greater Character
#
# See https://wlmb.github.io/2022/10/31/PWC189/#task-1-greater-character
use v5.36;
use List::Util qw(first all);
die <<"EOF" unless @ARGV>1;
Usage: $0 target c1 c2...
To find smallest char ci larger than target
EOF
die "Only single chars in range a..z allowed" unless all {/^[a-z]$/} @ARGV;
my ($target,@array)=@ARGV;
say join " ", @array, ": $target ->",
    (first {$_ gt $target} sort @array) # smallest char after target or
    //$target;                          # funny default
