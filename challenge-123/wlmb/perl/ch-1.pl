#!/usr/bin/env perl
# Perl weekly challenge 123
# Task 1: Ugly numbers
#
# See https://wlmb.github.io/2021/07/27/PWC123/#task-1-ugly-numbers

use warnings;
use strict;
use v5.12;
my @uglies=(1); #known uglies
my @u_id=(0,0,0); # indices into uglies array corresponding to
my @factors=(2,3,5); # prime factors of uglies

foreach(@ARGV){
    say "Input: $_ Output: ", ugly($_);
}

sub ugly {
    my $n=shift @_; # desired ugly number
    while($n>@uglies){
	my ($next_id)=sort {$uglies[$u_id[$a]]*$factors[$a]<=>$uglies[$u_id[$b]]*$factors[$b]}
	               (0..2);
	my $next_val=$uglies[$u_id[$next_id]]*$factors[$next_id];
	$u_id[$next_id]++;
	next unless $next_val>$uglies[-1];
	push @uglies, $next_val;
    }
    return $uglies[$n-1];
}
