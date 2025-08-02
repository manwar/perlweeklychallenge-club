#!/usr/bin/env perl
# Perl weekly challenge 255
# Task 2:  Most Frequent Word
#
# See https://wlmb.github.io/2024/02/05/PWC255/#task-2-most-frequent-word
use v5.36;
use List::UtilsBy qw(max_by);
die <<~"FIN" unless @ARGV==2;
    Usage: $0 S ¨P
    to find the most frequent word in paragraph P excluding the word S
    FIN
my ($w, $p)=@ARGV;
my %count;
++$count{fc $_} for split /\W+/, $p;
delete $count{fc $w};
say "\n$w\n$p\n->\n", max_by{$count{$_}} keys %count;
