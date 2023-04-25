#!/usr/bin/env perl
# Perl weekly challenge 214
# Task 1:  Rank Score
#
# See https://wlmb.github.io/2023/04/24/PWC214/#task-1-rank-score
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2..]
    to rank the scores S1 S2...
    FIN
my @scores=@ARGV;
my @ranks=(qw(Gold Silver Bronce), 4..@scores); # G S B 4 5 6...
my $counter;
my %score_to_rank;
map {my $current=$ranks[$counter++]; $score_to_rank{$_}//=$current}
    sort {$b<=>$a} @scores;
say join " ", @scores, "->", @score_to_rank{@scores}
