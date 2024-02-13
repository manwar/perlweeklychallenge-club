#!/usr/bin/env perl
# Perl weekly challenge 256
# Task 2:  Merge Strings
#
# See https://wlmb.github.io/2024/02/12/PWC256/#task-2-merge-strings
use v5.36;
sub next_char($x){
    shift @$x||""
}
my ($x,$y)=map{[split ""]}@ARGV;
my $out="";
$out.=next_char($x) . next_char($y) while(@$x||@$y);
say "@ARGV -> $out"
