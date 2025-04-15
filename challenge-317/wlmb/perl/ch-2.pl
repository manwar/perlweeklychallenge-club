#!/usr/bin/env perl
# Perl weekly challenge 317
# Task 2:  Friendly Strings
#
# See https://wlmb.github.io/2025/04/14/PWC317/#task-2-friendly-strings
use v5.36;
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S11 S12 S21 S22...
    to find if strings Sn1 and Sn2 are friendly, i.e.,
    match after one swap.
    FIN
for my ($str1, $str2)(@ARGV){
    my ($arr1, $arr2)=map {[split ""]}($str1, $str2);
    my $differences=0;
    $arr1->[$_] eq $arr2->[$_] || ++$differences for(0..$arr1->@*-1);
    my ($sorted1, $sorted2) = map{join "",sort{$a cmp $b}@$_} ($arr1, $arr2);
    my @uniq = uniq @$arr1;
    my $result = ($sorted1 eq $sorted2 # same letters
		  &&
		  ($differences == 2 # exactly two differences
		   || ($differences == 0 && @uniq != @$arr1) # or repeated letter
		  )) ? "True" : "False";
    say "$str1 $str2 -> $result";
}
