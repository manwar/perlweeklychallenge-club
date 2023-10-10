#!/usr/bin/env perl
# Perl weekly challenge 238
# Task 2:  Persistence Sort
#
# See https://wlmb.github.io/2023/10/09/PWC238/#task-2-persistence-sort
use v5.36;
use List::Util qw(product all);
use POSIX qw(floor);
sub steps($x){
    my $result=0;
    ++$result , $x=product split "", $x
	while($x>=10);
    $result
}
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to sort the list N1 N2 according to the number of steps required
    to bring the number to one digit and then according to value
    FIN
die "Only natural numbers allowed" unless all {0<=floor($_)&&floor($_)==$_} @ARGV;
say "@ARGV -> ", join " ",
    sort {steps($a)<=>steps($b)||$a<=>$b} @ARGV
