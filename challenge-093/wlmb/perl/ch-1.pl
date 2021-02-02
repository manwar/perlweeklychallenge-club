#!/usr/bin/env perl
# Perl weekly challenge 093
# Task 1: Max points.
# Find maximum number of points on a line
# See https://wlmb.github.io/2020/12/28/PWC93/#task-1-max-points
use warnings;
use strict;
use v5.10;

use List::Util qw(all reduce);
use Scalar::Util qw(looks_like_number);

usage() unless @ARGV; # Expect at least one argument
while(my $points=shift @ARGV){ # for each input line
    my @points;
    my %seen;
    foreach(split ' ', $points){ # separate it in points
	usage()
	    unless /^\((.*),(.*)\)$/
		       and looks_like_number($1) and looks_like_number($2);
	push @points, [$1,$2] unless $seen{0+$1}{0+$2}++; # 0+ trick.
    }
    my @max_line=max_line(@points); # choose the line with most points
    say "Input: $points\nLongest line: ", # and print it sorted
	join(" ", map {"($_->[0],$_->[1])"}
	     sort {$a->[0] <=> $b->[0]
		       || ($a->[0] == $b->[0] && $a->[1] <=> $b->[1])}
	     @max_line),
	"\nMax points: ", scalar @max_line, "\n"; # finally print the 'length'
}

sub max_line {
    my @lines;
    add_point($_, \@lines) foreach(@_); # build all lines
    return @{my $max=reduce {@$a > @$b?$a:$b } @lines}; #return longest line
}

sub add_point {
    my $point=shift;
    my $lines=shift;
    foreach(my @previous_lines=@$lines){
        push(@$lines, [$_->[0], $point]), next if @$_==1; # new two-point line
	push(@$_, $point), next # add point to existing line if co-linear
	    if (($_->[1][0]-$_->[0][0])*($point->[1]-$_->[0][1])
		 ==($_->[1][1]-$_->[0][1])*($point->[0]-$_->[0][0]))
    }
    push @$lines, [$point]; # new one-point degenerate line
}

sub usage {
      say <<'END_USAGE';
      Usage: ./ch-1.pl "(x0,y0) (x1,y1),..." ["(x'0,y'0)..." ...]
      where xn and yn are numbers and there is no space within the parenthesis.

      Find the maximum number of colinear points rn=(xn,yn) on the plane.
END_USAGE
    exit 1;
}
