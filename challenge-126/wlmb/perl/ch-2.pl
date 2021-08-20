#!/usr/bin/env perl
# Perl weekly challenge 126
# Task 1:  Minesweeper game
#
# See https://wlmb.github.io/2021/08/20/PWC126/#task-2-mineseeper-game
use warnings;
use strict;
use v5.12;
use PDL;
use PDL::Image2D;

my %translate=('x'=>1, '*'=>0);
my $input=process_input();
my $count=conv2d($input, ones(3,3), {Boundary=>'Truncate'});
my $output=-10*$input+$count; #mine sites get negative numbers
# Make strings and remove brackets
(my $input_str="$input")=~tr(01[])(*x)d;
my $output_str="$output";
$output_str=~s/-\d+/ x/g;
$output_str=~s/ +/ /g;
$output_str=~tr([])()d;
say "Input:$input_str\nOutput:$output_str";

sub process_input {
    my $length;
    my @input;
    while(<>){ # read input from STDIN
	chomp;
	next if /^\s*$/; #ignore null lines
	die "Only 'x' and '*' and spaces allowed: $_" unless m/^[x*\s]*$/;
	my @line=map {$translate{$_}} split ' ', $_;
	die "All lines should have the same length: $_"
	    if defined $length and $length!=@line;
	$length//=@line;
	push @input, [@line];
    }
    my $input=pdl [@input];
}
