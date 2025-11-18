#!/usr/bin/env perl
# Perl weekly challenge 348
# Task 1:  String Alike
#
# See https://wlmb.github.io/2025/11/17/PWC348/#task-1-string-alike
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to check if string Sn can be split into equal length parts with the
    same number of vowels
    FIN
for(@ARGV){
    my $length=length(my $second=$_);
    my $first=substr $second,0,$length/2,"";
    my ($vowels_first, $vowels_second)=
        map{tr/aeiouAEIOU//d}$first, $second;
    my $result= $length%2==0 &&  $vowels_first == $vowels_second?"True":"False";
    say "$_-> $result";
}
