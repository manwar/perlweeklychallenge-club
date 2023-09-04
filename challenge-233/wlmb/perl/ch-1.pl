#!/usr/bin/env perl
# Perl weekly challenge 233
# Task 1:  Similar Words
#
# See https://wlmb.github.io/2023/09/04/PWC233/#task-1-similar-words
use v5.36;
use List::Util qw(uniq sum0);
die <<~"FIN" unless @ARGV;
    Usage: $0 w1 [w2...]
    to count pairs of related words w1, w2, etc.
    FIN
my %count;
# convert to lower case, split, find unique elements, sort them and join them
# to obtain unique representation of characters of word. Count how many appear.
$count{join "", sort {$a cmp $b} uniq split "", lc($_)}++ for (@ARGV);
my %pairs;
$pairs{$_}=$count{$_}*($count{$_}-1)/2 for grep {$count{$_}>=2} keys %count;
my $result=sum0 values %pairs;
say "@ARGV -> $result";
