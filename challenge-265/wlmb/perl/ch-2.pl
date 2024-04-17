#!/usr/bin/env perl
# Perl weekly challenge 265
# Task 2:  Completing Word
#
# See https://wlmb.github.io/2024/04/16/PWC265/#task-2-completing-word
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV;
    Usage: $0 S [W1...]
    to find the shortest completing word of string S among the words W1, W2...
    FIN
my ($string, @words)=@ARGV;
my %frequencies = count_letters($string);
my @ordered= sort {length $a <=> length $b || $a cmp $b}
             grep {
                 my %c=count_letters($_);
                 all {
                     ($c{$_}//0) >= $frequencies{$_}
                 }
                 keys %frequencies
             } @words;
say "str=\"$string\" words=@words -> ", $ordered[0] // '""';
sub count_letters($word){
    my %count;
    $count{$_}++ for grep {/[a-z]/} split "",lc $word;
    %count
}
