#!/usr/bin/env perl
# Perl weekly challenge 208
# Task 2:  Duplicate and Missing
#
# See https://wlmb.github.io/2023/03/13/PWC208/#task-2-duplicate-and-missing
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to find missing numbers and duplicates in the list N1 N2...
    FIN
my @list=sort {$a <=> $b} @ARGV;
my $previous=shift @list;
my @duplicates;
my @missing;
for(@list){
    push @duplicates, $_ if $_==$previous;
    push @missing, $previous+1..$_-1;
    $previous=$_
}
push @missing, $previous+1 unless @missing; # missing after last for default
die "More than one duplicate\n" if @duplicates>1;
die "More than one missing\n" if @missing>1;
my $result=@duplicates?"(@duplicates @missing)":-1;
say "@ARGV -> $result";
