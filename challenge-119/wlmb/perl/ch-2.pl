#!/usr/bin/env perl
# Perl weekly challenge 119
# Task 2: sequence without 1-on-1
#
# See https://wlmb.github.io/2021/06/21/PWC119/#task-2-sequence-without-1-on-1

use strict;
use warnings;
use v5.12;
use integer;

map {say "Input: $_, Output: ", get($_)} @ARGV;
sub get {
    my $want=shift;
    my $n=1; #counter
    my $r;
    while($want-- > 0){
	while(!defined ($r=convert($n++))){};
    }
    return $r;
}

sub convert {
    my $n=shift;
    my $r="";
    return 0 if $n==0;
    while($n>0){
	$r=$n%4 . $r;
	$n/=4;
    }
    return ($r=~m/11/ || $r=~/0/)?undef:$r;
}
