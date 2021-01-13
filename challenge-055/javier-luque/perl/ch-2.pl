#!/usr/bin/perl
# Test: ./ch-1.pl 4
use strict;
use warnings;
use feature qw /say/;
use Algorithm::Combinatorics qw(permutations);

my $n = $ARGV[0];
my @array = (1 .. $n);

# Permutations
my $iter = permutations(\@array);

# Loop through each combination
while (my $p = $iter->next) {
    my $is_wave = 1;

    for (my $i = 1; $i < scalar(@$p); $i++) {
    	if ( $i % 2 == 1 && $p->[$i] >= $p->[$i - 1] ||
    	     $i % 2 == 0 && $p->[$i] <= $p->[$i - 1] ) {;
    		$is_wave = 0;
    		last;
    	}
    }

    say join ' ', @$p if ($is_wave);
}
