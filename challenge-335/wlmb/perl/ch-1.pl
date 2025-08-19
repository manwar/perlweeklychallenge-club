#!/usr/bin/env perl
# Perl weekly challenge 335
# Task 1:  Common Characters
#
# See https://wlmb.github.io/2025/08/18/PWC335/#task-1-common-characters
use v5.36;
use List::Util qw(min);
die <<~"FIN" unless @ARGV;
    Usage: $0 W1 W2...
    to show characters common to all words W1 W2...
    FIN
my @words;
for(@ARGV){                                                 # count letters in each word
    my %letters;
    $letters{$_}++ for split "", $_;
    push @words, {%letters}
}
my %result=%{$words[0]};                                    # check letters in first word
for my $letter(keys %result){
    $result{$letter}=min map{$_->{$letter}//0} @words
}
say "@ARGV -> ", map {"$_ " x $result{$_}}
                 sort {$a cmp $b} keys %result;
