#!/usr/bin/env perl
# Perl weekly challenge 191
# Task 2:  Cute List. Economize memory
#
# See https://wlmb.github.io/2022/11/14/PWC191/#task-2-cute-list
use v5.36;
use List::Util qw(all any);
use Set::CrossProduct;
sub cute($n){ # iterator over cute sequences
    my @sets;
    for my $position(0..$n-1){
        for(1..$n){
            push @{$sets[$position]}, $_ if ($position+1)%$_==0 || $_%($position+1)==0;
	}
    }
    my $iter=Set::CrossProduct->new([@sets]);
    return sub {
	ITER: while(my $tuple=$iter->get()){
            my @seen;
            for(@$tuple){
	        next ITER if $seen[$_];
                ++$seen[$_];
            }
	    return $tuple;
	}
	return;
    }
}
die << "EOF" unless @ARGV;
Usage: $0 N1 [N2...]
to count the cute orderings of 1..Ni
EOF
die "Only numbers in the range 1..15 are allowed" unless all {1<=$_<=15} @ARGV;
for(@ARGV){
    my $iter=cute($_);
    my $count=0;
    ++$count while $iter->();
    say "$_ -> $count";
}
