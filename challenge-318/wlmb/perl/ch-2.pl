#!/usr/bin/env perl
# Perl weekly challenge 318
# Task 2:  Reverse Equals
#
# See https://wlmb.github.io/2025/04/21/PWC318/#task-2-reverse-equals
use v5.36;
die <<~"FIN" unless @ARGV==2;
    Usage: $0 A1 A2
    to check if the arrays of numbers become equal after reversing one subarray.
    Each array is a space separated string.
    FIN
my ($array1, $array2)=map {[split " "]} @ARGV;
my ($sorted1, $sorted2)=map {[sort {$a <=> $b} @$_]} ($array1, $array2);
eat_equal($sorted1, $sorted2);
die "Arrays should have the same elements" unless @$sorted1==@$sorted2==0;
eat_equal($array1, $array2);
my ($reverse1, $reverse2)=map {[reverse @$_]} ($array1, $array2);
eat_equal($reverse1, $reverse2);
my $revreverse1=[reverse @$reverse1];
eat_equal($revreverse1, $reverse2);
my $result=@$revreverse1==@$reverse2==0?"True":"False";
say "$ARGV[0]; $ARGV[1] -> $result";

sub eat_equal($p, $q){    # eat equal numbers from the front of arrays $p and $q
    while(@$p && $p->[0]==$q->[0]){
	shift $_->@* for ($p,$q);
    }
}
