#!/usr/bin/env perl
# Perl weekly challenge 218
# Task 1:  Maximum Product
#
# See https://wlmb.github.io/2023/05/22/PWC218/#task-1-maximum-product
use v5.36;
use List::Util qw(all product);
say <<~"FIN" unless @ARGV >= 3;
    Usage: $0 N1 N2 N3 [N4...]
    to find the maximum product of three numbers from
    the list N1 N2...
    FIN
my $no_positive= all {$_<=0} @ARGV;
my $result;
if($no_positive){
    my @sorted=sort {$b <=> $a} @ARGV;
    $result=product splice @sorted,0,3;
}else{
    my @sorted = sort {abs($b) <=> abs($a)} @ARGV;
    my @result = sort by_strange_criteria splice @sorted, 0, 3;
    $result[0] = shift @sorted while((product @result) <= 0 && @sorted);
    $result = product @result;
}
say "@ARGV->", $result;
sub by_strange_criteria {
    return -1 if $a<0 and $b >=0;
    return $b<=>$a if $a < 0 and $b < 0;
    return 1 if $b<0 and $a >= 0;
    return $a<=>$b;
}
