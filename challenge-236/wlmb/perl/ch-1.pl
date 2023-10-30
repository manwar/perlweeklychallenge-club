#!/usr/bin/env perl
# Perl weekly challenge 236
# Task 1: Exact Change
#
# See https://wlmb.github.io/2023/09/24/PWC236/#task-1-exact-change
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 B1 [B2...]
    to see if you can sell $5 juice taking bills B1, B2... and giving
    exact change.
    FIN
my  @sorted_input=sort {$a<=>$b} @ARGV;
my $success=1;
my %cash_box;
my $remaining_change;
for(@sorted_input){
    ++$cash_box{$_};
    $remaining_change=$_-5;
    for(10,5){
        $remaining_change-=$_, --$cash_box{$_}
	    while $remaining_change>=$_ && $cash_box{$_};
    }
    $success &&= !$remaining_change;
}
say "@ARGV -> ", $success?"true":"false";
