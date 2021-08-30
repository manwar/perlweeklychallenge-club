#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated binary words, with one word representing each row>

use List::Util qw(reduce);
use List::UtilsBy qw(max_by);

my ($rows,$cols)=(0,0);
my $digs = length $ARGV[0];
for my $i (0..scalar @ARGV-1) {
    for my $j ($i..scalar @ARGV-1) {
	my $max = max_by { length $_ } split /[^0]+/, reduce { sprintf("%0${digs}b", oct("0b$a") | oct("0b$b")) } @ARGV[$i..$j];
	if (($j-$i+1) * (length $max) > $rows * $cols) {
	    ($rows,$cols) = ($j-$i+1, length $max);
	}
    }
}

say join "\n", ('0' x $cols) x $rows; 
