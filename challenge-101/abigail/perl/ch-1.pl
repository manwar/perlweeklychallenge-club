#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

use List::Util 'max';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

my $RIGHT = 0;
my $UP    = 1;
my $LEFT  = 2;
my $DOWN  = 3;

#
# Read in the data; we're assuming the elements are separated by whitespace.
# We can easily change this without effecting the rest of the program.
#
my @elements = split ' ' => scalar <>;

#
# Find optimal sizes: width $w and height $h
# We start at the square root, and count downwards till we
# have a divider. 
#
my $h = int sqrt @elements;
for (; @elements % $h;) {
    $h --;
}

my $w = @elements / $h;


#
# Fill a matrix, starting from the bottom left.
#
my $matrix;
my ($min_x, $max_x, $min_y, $max_y) = (0, $h - 1, 0, $w - 1);
my $x = $max_x;
my $y = $min_y;
my $direction = $RIGHT;
foreach my $element (@elements) {
    $$matrix [$x] [$y] = $element;
    my $turn = 0;
    if ($direction == $RIGHT) {
        if   ($y >= $max_y) {$turn = 1; $x --; $max_x --}
        else {$y ++}
    }
    if ($direction == $UP) {
        if   ($x <= $min_x) {$turn = 1; $y --; $max_y --}
        else {$x --}
    }
    if ($direction == $LEFT) {
        if   ($y <= $min_y) {$turn = 1; $x ++; $min_x ++}
        else {$y --}
    }
    if ($direction == $DOWN) {
        if   ($x >= $max_x) {$turn = 1; $y ++; $min_y ++}
        else {$x ++}
    }
    if ($turn) {
        $direction ++;
        $direction %= 4;
    }
}

#
# Pretty print array; we're making sure all the columns are aligned.
#

my @widths = map {my $y = $_;
                  max map {length $$matrix [$_] [$y]} 0 .. $h - 1} 0 .. $w - 1;

foreach my $row (@$matrix) {
    for (my $y = 0; $y < @$row; $y ++) {
        my $width = $widths [$y];
        printf "%s%${width}s" => $y ? " " : "", $$row [$y];
    }
    print "\n";
}

__END__
