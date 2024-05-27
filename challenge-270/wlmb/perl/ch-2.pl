#!/usr/bin/env perl
# Perl weekly challenge 270
# Task 2:  Distribute Elements
#
# See https://wlmb.github.io/2024/05/20/PWC270/#task-2-distribute-elements
use v5.36;
die <<~"FIN" unless @ARGV >= 2;
    Usage: $0 X Y A1 A2...
    to find the minimum cost of maeking all elements of the array A1 A2... equal
    by adding 1 to individual elements, with cost X or adding 1 to pairs of
    elements with cost Y.
    FIN
my ($x, $y)=(shift,shift);
my $prefer_two=$y<2*$x;
my @decreasing = sort {$b<=>$a} @ARGV;
my $max = shift @decreasing;
my $total = 0;
while(@decreasing){
    my $steps = $max - shift @decreasing;
    if($prefer_two && @decreasing){ # Can I do level 2?
	$decreasing[0] += $steps;   # Update next element
	$total += $steps * $y;      # Update total cost
    }else{                          # level 1 instead
	$total += $steps * $x;      # Update total cost
    }
}
say "x=$x, y=$y, ints= @ARGV -> $total"
