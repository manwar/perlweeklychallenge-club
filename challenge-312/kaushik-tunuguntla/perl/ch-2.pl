#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(all);

print('Enter the balls and boxes string: ');
my $str = <STDIN>;
chomp($str);

my $i=0;
my @balls_boxes = split(//, $str);
my %count;
while($i <= $#balls_boxes) {
    my $ball = $balls_boxes[$i];
    my $box = $balls_boxes[$i+1];
    $count{$box}{$ball} = 1;
    $i += 2;
}
my $count = 0;
foreach my $box (keys %count) {
    if (scalar keys %{$count{$box}} == 3) {
        $count++;
    }
}
print("Number of boxes containing all three colours: $count\n");