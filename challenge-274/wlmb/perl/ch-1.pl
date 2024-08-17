#!/usr/bin/env perl
# Perl weekly challenge 274
# Task 1:  Goat Latin
#
# See https://wlmb.github.io/2024/06/17/PWC274/#task-1-goat-latin
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to rewrite sentences S1 S2... in Goat Latin
    FIN
while(@ARGV){
    my @words=split " ", my $sentence=shift;
    my $count=1;
    my @out;
    for(@words){
	s/^(?=[a-z])([^aeiou])(.*)/$2$1/i;
	$_.="ma"."a"x$count++;
    }
    say "$sentence -> @words"
}
