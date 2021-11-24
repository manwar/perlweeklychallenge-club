#!/usr/bin/env perl
# Perl weekly challenge 140
# Task 2: Multiplication Table
#
# See https://wlmb.github.io/2021/11/23/PWC140/#task-2-multiplication-table
use v5.12;
use warnings;
use integer;
use PDL;
use PDL::NiceSlice;

say("Usage: ./ch-2.pl i j k to get the k-th element of an iXj multiplication table"),
    exit unless @ARGV==3;
my($i, $j, $k)=@ARGV;
say("i and j should be positive"), exit unless $i>=1 && $j>=1;
say("k should be positive and not greater than iXj"), exit unless 1<=$k<=$i*$j;

my $result=(
    my $sorted=(
	my $table=(zeroes($j,$i)->ndcoords+1)->prodover
        )->flat->qsort
    )->(($k-1));
say "Input: i=$i, j=$j, k=$k,\nOutput=$result",
	    "\nsince the ${i}X$j multiplication table is",
    $table, "which sorted becomes\n$sorted,\nwhose $k-th element is $result\n";
