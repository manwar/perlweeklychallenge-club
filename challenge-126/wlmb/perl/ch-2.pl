#!/usr/bin/env perl
# Perl weekly challenge 126
# Task 1:  Minesweeper game
#
# See https://wlmb.github.io/2021/08/20/PWC126/#task-2-mineseeper-game
use warnings;
use strict;
use v5.12;
use PDL;
use PDL::Image2D; # for conv2d

my $input=process_input();
my $kernel=pdl([1,1,1],[1,-9,1],[1,1,1]);
my $output=$input->conv2d($kernel, {Boundary=>'Truncate'});
# Make strings and format them
(my $input_str="$input")=~tr(01[])(*x)d; #translate and remove brackets
my $output_str="$output";
$output_str=~s/-\d+/ x/g; #identify sites with bombs
$output_str=~s/ +/ /g; #separate sites with single spaces
$output_str=~tr([])()d; #remove brackets
say "Input:$input_str\nOutput:$output_str";

sub process_input {
    my $length;
    my @input;
    while(<>){ # read input from STDIN
	chomp;
	next if /^\s*$/; #ignore null lines
	die "Only 'x' and '*' and spaces allowed: $_" unless m/^[x* \t]*$/;
	tr(*x \t)(01)d;
	my @line=split '';
	die "All lines should have the same length: $_"
	    if defined $length and $length!=@line;
	$length//=@line;
	push @input, [@line];
    }
    pdl [@input];
}
