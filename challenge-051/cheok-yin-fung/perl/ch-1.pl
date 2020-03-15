#!/usr/bin/perl
use strict;
use Math::Combinatorics;
use List::Util qw{sum};

#Usage: ch-1.pl $target $L[0] $L[1] ... $L[$#L];

my $target = shift @ARGV;

my @L = @ARGV;


my $tripets = Math::Combinatorics->new( count => 3 , data => [@L] );

while (my @tsum = $tripets->next_combination) {
	print join(" ", sort {$a<=>$b} @tsum)."\n" if $target == sum @tsum;
}
