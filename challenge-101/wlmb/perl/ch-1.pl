#!/usr/bin/env perl
# Perl weekly challenge 101
# Task 1: Pack a spiral
#
# See https://wlmb.github.io/2021/02/22/PWC101/#task-1-pack-a-spiral
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);
use List::Util qw(first);

sub usage {
    say "./ch-1.pl item1 item2...\nArranges items in spiral";
    exit 1;
}

my $M=first {@ARGV%$_==0} reverse(1..sqrt @ARGV); #Highest divisor below sqrt
my $N=@ARGV/$M; #smallest divisor above sqrt
my $result=[[]]; #
my @current_coords=(0,-1); # starting position, left of first array element

my $right;
my $down= build_moves(0,-1,  0, \$right);
my $left= build_moves(1,-1, -1, \$down);
my $up=   build_moves(0, 1, $N, \$left);
$right=   build_moves(1, 1, $M, \$up);
my $next_move=$right; # First move to try

usage() unless @ARGV; #At least some argument is required
for(@ARGV){
    &$next_move();
    $result->[$current_coords[0]][$current_coords[1]]=$_;
}
say join " ", "Input:", @ARGV;
say join "\n", "Output:", reverse map {join "\t", @$_} @$result;

sub build_moves {
    my $index=shift; # which coordinate to affect
    my $delta=shift; # increment
    my $border=shift; # current position of border
    my $next=shift;  # next direction to try.
    sub {
	if($current_coords[$index]+$delta==$border){
	    $next_move=$$next;
	    $border= $border-$delta;
	    $next_move->();
	} else {
	    $current_coords[$index]+=$delta;
	}
    }
}
