#!/usr/bin/env perl
# Perl weekly challenge 298
# Task 2:  Right Interval
#
# See https://wlmb.github.io/2024/12/02/PWC298/#task-2-right-interval
use v5.36;
use PDL;
use PDL::NiceSlice;
use List::AllUtils qw(first);
for(@ARGV){
    my $p=pdl($_);
    my @list=append($p->yvals->(0), $p)->dog;
    my @sorted=sort {$a((1)) <=> $b((1))} @list;
    my @results =
	map {$_((0))}
        sort{$a((1))<=>$b((1))}
        my @next =
        map {
	    my $x=$sorted[$_];
	    my $i=first {$_((1))>=$x((2))} @sorted[$_..@sorted-1];
	    append(defined $i?$i((0)):-1, $x)
        }0..@sorted-1;
    say "$_ -> [@results]";
}
