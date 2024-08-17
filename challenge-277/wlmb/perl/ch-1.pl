#!/usr/bin/env perl
# Perl weekly challenge 277
# Task 1:  Count Common
#
# See https://wlmb.github.io/2024/07/08/PWC277/#task-1-count-common
use v5.36;
use experimental qw(for_list);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S11 S12 [S21 S22...]
    to count pair of words that appear once in the space separated
    strings Sn1 and Sn2.
    FIN
for my ($s1, $s2)(@ARGV){
    my @strings=($s1, $s2);
    my @counts;
    my $i=0;
    for(@strings){
	$counts[$i]{lc $_}++ for split " ", $_;
	$i++;
    }
    say((map{"words$_ = [$strings[$_]] "}(0,1)), " -> ",
	0+grep{$counts[0]{$_}==$counts[1]{$_}==1}keys %{$counts[0]});
}
