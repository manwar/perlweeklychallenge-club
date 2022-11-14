#!/usr/bin/env perl
# Perl weekly challenge 190
# Task 1:  Capital Detection
#
# See https://wlmb.github.io/2022/11/07/PWC190/#task-1-capital-detection
use v5.36;
use List::Util qw(any);
die <<"EOF" unless @ARGV;
Usage: $0 W1 [W2...]
to test appropriate case for the words W1, W2,...
EOF
for my $word(@ARGV){
    say "$word -> ",
    (any {$word eq $_} lc $word, uc $word, ucfirst lc $word)
    ? "appropriate": "inappropriate"}
