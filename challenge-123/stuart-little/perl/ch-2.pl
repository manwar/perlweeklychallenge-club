#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <x1 y1 x2 y2 ..>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub sqDist($x1, $y1, $x2, $y2) {
    return ($x2-$x1)**2 + ($y2-$y1)**2;
}

sub sqDistHash($coords) {
    my %h;
    for my $i (0..2) {
	for my $j ($i+1..3) {
	    $h{sqDist($coords->[2*$i],$coords->[2*$i+1],$coords->[2*$j],$coords->[2*$j+1])}++;
	}
    }
    return \%h;
}

sub isSq($coords) {
    my @distCounts = values %{sqDistHash($coords)};
    return(((grep {$_==2} @distCounts) && (grep {$_==4} @distCounts)) ? (1) : (0));
}

my @coords=@ARGV[0..7];
say isSq(\@coords);
