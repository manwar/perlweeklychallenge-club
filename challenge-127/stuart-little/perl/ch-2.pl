#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <left1 right1 left2 right2 ...>

my @sol;

for my $j (1..int((scalar @ARGV)/2)-1) {
    for my $i (0..$j-1) {
	(($ARGV[2*$j+1]-$ARGV[2*$i])*($ARGV[2*$j]-$ARGV[2*$i+1]) <= 0) && do {
	    push @sol, [$ARGV[2*$j], $ARGV[2*$j+1]];
	    last;
	};
    }
}

for (@sol) {
    say "@{$_}";
}
