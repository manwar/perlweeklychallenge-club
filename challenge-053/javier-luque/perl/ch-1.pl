#!/usr/bin/perl
# Test: ./ch-1.pl
use strict;
use warnings;
use feature qw /say/;

# 3 x 3 matrix
my $three = [
    [1,2,3],
    [4,5,6],
    [7,8,9],
];

say 'Original ';
print_matrix($three);

for (my $i = 1; $i < 4; $i++) {
    say 'Rotate ' . 90 * $i;
    rotate_matrix($three);
    print_matrix($three);
}

# Rotate the matrix
sub rotate_matrix {
    my $m = shift;

    # Size of the matrix
    my $n = scalar(@$m);

    for (my $i = 0; $i < int($n / 2); $i++) {
    	for (my $j = $i; $j < $n - $i - 1; $j++) {
    		my $temp = $m->[$i]->[$j];
    		$m->[$i]->[$j]           = $m->[$n-$j-1]->[$i];
    		$m->[$n-$j-1]->[$i]      = $m->[$n-$i-1]->[$n-$j-1];
    		$m->[$n-$i-1]->[$n-$j-1] = $m->[$j]->[$n-$i-1];
    		$m->[$j]->[$n-$i-1]      = $temp;
    	}
    }
}

# Print the matrix
sub print_matrix {
    my $m = shift;

    # Max length of the attributes
    my $length = length(scalar(@$m)**2) + 1;

    for my $row (@$m) {
    	say map { sprintf ( " %${length}d", $_ ) } @$row;
    }
}
