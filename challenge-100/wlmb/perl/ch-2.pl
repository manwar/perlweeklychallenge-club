#!/usr/bin/env perl
# Perl weekly challenge 100
# Task 2: Triangle Sum
#
# See https://wlmb.github.io/2021/02/15/PWC100/#task-2-triangle-sum
use strict;
use warnings;
use v5.12;
use List::Util qw(min);
use List::MoreUtils qw(pairwise);
# Read all numbers from @ARGV as a flat list arranging them into rows to build triangle
my @rows;
my @row;
foreach(@ARGV){
    push @row, $_;
    push(@rows, [@row]),@row=() if @row > @rows;
}
push @rows,[@row] if @row; # add the last row
my $expected=@rows*(@rows+1)/2; #expected triangular number
my $got=@ARGV;
die "Not enough numbers. Expected $expected, got $got" unless $expected==$got;

# Build the optimum paths for each row combining them with those of the next row
my @next_row=(0)x@{$rows[-1]};
my $cost;
my @choices;
foreach my $current_row(reverse @rows){ # move upwards
    my @current_row=pairwise {$a+$b} @$current_row, @next_row; #get totalcost for each element
    $cost=$current_row[0],last if @current_row==1; # done?
    # Find best choices for each index of the row above
    my @chosen_indices=map {$current_row[$_]<=$current_row[$_+1]?$_:$_+1}(0..@current_row-2);
    @next_row=@current_row[@chosen_indices];
    # Build a triangle of chosen indices for later display
    unshift @choices, [@chosen_indices];
}
#print input triangle and optimal cost
say "Input:\n", join "\n", map {join " ", @$_} @rows;
say "Output: $cost";
say "Explanation:"; # Print triangle bracketing chosen path
my $best_index=0;
foreach my $i(0..@rows-1){ #Indices of rows
    my $row=$rows[$i];
    my $choice=$choices[$i];
    say join " ", map {$_==$best_index?"[$row->[$_]]":$row->[$_]} (0..@$row-1);
    $best_index=$choice->[$best_index];
}
