#!/usr/bin/env perl
# Perl weekly challenge 102
# Task 2: Hash-counting string
#
# See https://wlmb.github.io/2021/03/01/PWC102/#task-2-hash-counting-string
use strict;
use warnings;
use v5.12;

foreach my $length(@ARGV){
    my $remaining=$length;
    my @pieces;
    while($remaining>0){
	unshift @pieces, $remaining==1?"#":"$remaining#";
	$remaining-=length $pieces[0];
    }
    say "Length: $length\tString: ", join '', @pieces;
}
