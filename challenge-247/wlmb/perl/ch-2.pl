#!/usr/bin/env perl
# Perl weekly challenge 247
# Task 2:  Most Frequent Letter Pair
#
# See https://wlmb.github.io/2023/12/11/PWC247/#task-2-most-frequent-letter-pair
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 [S2...]
    to find the most frequent pair of consecutive letters
    from each of the strings S1, S2...
    FIN
for(@ARGV){
    my @letters=split "";
    my $first=shift @letters;
    my %count;
    $count{$_}++ for map{my $previous=$first; $first=$_; "$previous$first"}@letters;
    my @sorted =sort{$count{$b}<=>$count{$a}||$a cmp $b} keys %count;
    say "$_ -> $sorted[0]"
}
