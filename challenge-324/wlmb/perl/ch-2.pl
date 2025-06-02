#!/usr/bin/env perl
# Perl weekly challenge 324
# Task 2:  Total XOR
#
# See https://wlmb.github.io/2025/06/02/PWC324/#task-2-total-xor
use v5.36;
use List::Util qw(reduce sum);
sub f(@x){
    if(@x){
	my ($first, @rest)=@x;
	my @reduced=f(@rest);
	return @reduced, map{$first^$_}@reduced;
    }
    return (0);
}
say "@ARGV -> ", sum f(@ARGV);
