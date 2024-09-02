#!/usr/bin/env perl
# Perl weekly challenge 283
# Task 2:  Relative Sort
#
# See https://wlmb.github.io/2024/08/26/PWC283/#task-2-relative-sort
use v5.36;
use experimental qw(for_list);
use Scalar::Util qw(looks_like_number);
use List::Util qw(all);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 L11 L12 L21 L22...
    to sort the elements of the list Li1 using the ranks given by Li2.
    Lij is a string containing a list of string separated numbers.
    FIN
for my ($list, $order)(@ARGV){
    my @list=split " ", $list;
    my @order=split " ", $order;
    warn("Expected only numbers: $list; $order"), next
	unless all {looks_like_number($_)} (@list, @order);
    my %rank_of;
    $rank_of{$order[$_]}=$_ for 0..@order-1;
    my  %is_ranked;
    $is_ranked{$_}=defined $rank_of{$_}?1:0 for @list;
    my @sorted;
    @sorted= sort {
	 ($is_ranked{$b} <=> $is_ranked{$a})
	 || ($rank_of{$a}||0) <=> ($rank_of{$b}||0)
	 || $a <=> $b
    } @list;
    say "@list; @order -> @sorted";
}
