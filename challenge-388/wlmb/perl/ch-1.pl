#!/usr/bin/env perl
# Perl weekly challenge 388
# Task 1:  Dyck Words
#
# See https://wlmb.github.io/2026/08/24/PWC388/#task-1-dyck-words
use v5.36;
use Memoize;
use Text::Wrap qw(wrap $columns);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find all words formed by Nm letters U and Nm letters D
    so that no prefix has more D's than U's.
    FIN
memoize "dyck";
$columns = 60;
for(@ARGV){
    say wrap "", "\t", "$_ -> ", map {"\"". $_ ."\""}  dyck($_);
}

sub dyck($n,$m=0){
    return () if$m<0||$m>$n;
    return("") if $n==0;
    return ( map {$_ . "UD"} dyck( $n-1, 0) ),
	     map {$_ . "DD"} dyck( $n-1, 1)
	if $m == 0;
    return ( map {$_ . "UU"} dyck($n-1, $m-1) ),
	   ( map {$_ . "UD", $_ . "DU"} dyck($n-1, $m) ),
	     map {$_ . "DD" } dyck($n-1, $m+1);
}
