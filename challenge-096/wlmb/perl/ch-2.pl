#!/usr/bin/env perl
# Perl weekly challenge 096
# Task 2: Edit distance.
# Calculate the number of editions required to edit a string and convert it into another.
# See https://wlmb.github.io/2021/01/11/PWC096/#task-2-edit-distance

  use warnings;
  use strict;
  use v5.10;

  # Get the two strings to compare from @ARGV
  sub usage {
      say "Usage:\n\t./ch-2.pl from_string to_string\n\tComputes the cost to edit one string and produce the other";
      exit 1;
  }
  usage() unless @ARGV==2;
  my ($from, $to)=@ARGV;
  my @from=split '', $from;
  my @to=split '', $to;
  my $from_size=@from;
  my $to_size=@to;

my $costs;
my $operations;
# initialize the costs of $from->'' and ''->$to
$costs->[$_][0]=$_ foreach(0..$from_size); #deletions
$operations->[$_][0]='d' foreach(1..$from_size);
$costs->[0][$_]=$_ foreach(0..$to_size); #insertions
$operations->[0][$_]='i' foreach(1..$to_size);

#Build costs matrix and choose best operations for each pair of substrings.
foreach my $j(1..$to_size){
    foreach my $i(1..$from_size){
	my $subcost=$from[$i-1] eq $to[$j-1]?0:1; # substitution cost
	my($cost,$operation);
	($cost,$operation)=($costs->[$i-1][$j-1]+$subcost,
				  $subcost?"r":"k"); #for keep or substitute
	($cost,$operation)=($costs->[$i][$j-1]+1, "i")
	    if $costs->[$i][$j-1]+1 < $cost; #insertion
	($cost,$operation)=($costs->[$i-1][$j]+1, "d")
	    if $costs->[$i-1][$j]+1 < $cost; #deletion
	$costs->[$i][$j]=$cost;
	$operations->[$i][$j]=$operation;
    }
}

my $total_cost=$costs->[$from_size][$to_size];
my @operations;
my ($i, $j)=($from_size, $to_size);
# Obtain optimum sequence of operations by examining the $operations array
while($i>0 || $j>0){
    my $operation=$operations->[$i][$j];
    if($operation eq 'k'){
	unshift @operations, "(Keep $from[$i-1])";
	--$i;
	--$j;
	next;
    }
    if($operation eq 'r'){
	unshift @operations, "Replace $from[$i-1] by $to[$j-1]";
	--$i;
	--$j;
	next;
    }
    if($operation eq 'i'){
	unshift @operations, "Insert $to[$j-1]";
	--$j;
	next;
    }
	if($operation eq 'd'){
	unshift @operations, "Delete $from[$i-1]";
	--$i;
	next;
    }
    die "Wrong operation!"; # Shouldn't happen
}

say "Inputs: \"$from\" -> \"$to\"\nOutput: $total_cost\n";
say "Operation $_: $operations[$_-1]" foreach 1..@operations;
say;
