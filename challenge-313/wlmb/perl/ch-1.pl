#!/usr/bin/env perl
# Perl weekly challenge 313
# Task 1:  Broken Keys
#
# See https://wlmb.github.io/2025/03/17/PWC313/#task-1-broken-keys
use v5.40;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S1 T1 S2 T2...
    to check if the strings Tn typed in a broken typewriter
    correspond to the actual expected strings Sn.
    FIN
for my($name, $typed)(@ARGV){
    try {
	die "Only word letters allowed: $name" unless $name=~/^\w+$/;
	my $expression=$name;
	$expression=~s/(.)/$1+/g;
	my $result=($typed=~/$expression/)?"True":"False";
	say "name=$name, typed=$typed -> $result";
    }
    catch($e){
	say $e;
    }
}
