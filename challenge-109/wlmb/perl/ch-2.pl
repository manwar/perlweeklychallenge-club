#!/usr/bin/env perl
# Perl weekly challenge 109
# Task 2: Four squares puzzle
#
# See https://wlmb.github.io/2021/04/19/PWC109/#task-2-four-squares-puzzle
use strict;
use warnings;
use v5.12;
use List::Util qw(sum0);
use List::MoreUtils qw(uniq pairwise);

my @letters='a'..'g';
my %letters=map {($letters[$_], $_)}  0..$#letters;
my @squares=(['a','b'], ['b','c','d'], ['d','e','f'], ['f','g']);

die 'Usage: ./ch-2.pl n1 n2...n7 with 7 distinct numbers'
    unless @ARGV==7 and (uniq @ARGV)==7;
my $perm= permutator(@ARGV);
while(my @perm=$perm->()){
    next if (my @sums=uniq map {add($squares[$_], @perm)} (0..$#squares))>1;
    say +(pairwise {"$a=$b "} @letters, @perm),
	" since ", (join "=", map {join "+", @$_} @squares), "=$sums[0]";
    # last; # Could stop here if I only one solution is desired
}

sub add { #Sum the numbers within some square
    my $square=shift @_;
    my @numbers=@_;
    return sum0 map {$numbers[$letters{$_}]} @$square;
}

sub permutator { #returns an iterator for permutations
    my @items=@_;
    my $n_items=@items;
    my $n=0;
    my $done=0;
    sub {
	return if $done;
	my $which=$n; #next item to transpose
	return @items if $n++ == 0; #return first time through
	my $with_whom=1; #with whom to permute
	while($with_whom<=$n_items&&$which%$with_whom==0){
	    $which/=$with_whom;
	    ++$with_whom;
	}
	$done=1, return if $with_whom >$n_items; #no more transpositions
	$which=$with_whom-$which%$with_whom;
	#use negative indices to transpose rightmost first
	@items[-$with_whom+1..-1]=reverse @items[-$with_whom+1..-1]; #reorder
	@items[-$which,-$with_whom]=@items[-$with_whom,-$which]; # transpose
	return @items
    }
}
