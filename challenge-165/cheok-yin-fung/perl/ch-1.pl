#!/usr/bin/perl
# The Weekly Challenge 165
# Task 1 SVG
# Usage: $ ch-1.pl < DATA > IMG_FILE_NAME.svg

use v5.24.0;
use warnings;
use SVG;
use ARGV::OrDATA;

my $img = SVG->new;
my @points;

while (<>) {
    chomp;
    my @nums = split ",", $_;
    if (scalar @nums == 2) {
        push @points, [@nums];
    }
    elsif (scalar @nums == 4) {
        new_line(@nums);
    }
}

new_point($_->@*) foreach @points; #so that the lines won't be over points



sub new_point {
    my ($cx, $cy) = ($_[0], $_[1]);
    $img->circle(cx => $cx, cy => $cy, r => 2, style => {fill => 'red'});
}



sub new_line {
    my ($x1, $y1, $x2, $y2) = ($_[0], $_[1], $_[2], $_[3]);
    $img->line( x1 => $x1, y1 => $y1, x2 => $x2, y2 => $y2, 
    style => {
        'fill-opacity' => 0,
        'stroke'       => 'green'
    });
}


print $img->xmlify(-namespace=>'svg');

__DATA__
53,10
53,10,23,30
23,30
