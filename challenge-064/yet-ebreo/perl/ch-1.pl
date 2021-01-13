#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';


my @array = (
    # [1, 2, 3],
    # [4, 5, 6],
    # [7, 8, 9],
    [qw(1 0 0 9 9)],
    [qw(9 9 0 9 9)],
    [qw(9 0 0 9 9)],
    [qw(9 0 9 9 9)],
    [qw(9 0 0 0 1)],
);

my $min_sum = 1e9;
my $min_path = "";
my $max_x = $#{$array[0]};
my $max_y = $#array;

sub traverse {
    my ($arr, $x, $y, $sum, $path, $coords) = @_;

    # say $coords;
    if ($x == $max_x && $y == $max_y ) {
        # say "$sum: $path";
        if ($sum < $min_sum) {
            $min_sum = $sum;
            $min_path = $path;
        }
    }

    #right
    if ($x+1 <= $max_x) {

        my $xy = "[$y:".($x+1)."]";
        if ($coords !~ /\Q$xy/) {
            traverse ($arr, $x+1, $y, $sum+$arr->[$y][$x+1] , $path . " > " . $arr->[$y][$x+1], $coords.$xy)
        }
    
    }
    
    #down
    if ($y+1 <= $max_y) {

        my $xy = "[".($y+1).":$x]";
        if ($coords !~ /\Q$xy/) {
            traverse ($arr, $x, $y+1, $sum+$arr->[$y+1][$x] , $path . " > " . $arr->[$y+1][$x], $coords.$xy)
        }
        
    }

    #left
    if ($x-1 >= 0) {
        my $xy = "[$y:".($x-1)."]";
        if ($coords !~ /\Q$xy/) {
            traverse ($arr, $x-1, $y, $sum+$arr->[$y][$x-1] , $path . " > " . $arr->[$y][$x-1], $coords.$xy)
        }
    }

    #up
    if ($y-1 >= 0) {
        my $xy = "[".($y-1).":$x]";
        if ($coords !~ /\Q$xy/) {
            traverse ($arr, $x, $y-1, $sum+$arr->[$y-1][$x] , $path . " > " . $arr->[$y-1][$x], $coords.$xy)
        }
    }
}

traverse (\@array, 0, 0, $array[0][0], $array[0][0], "[0:0]");

say $min_path;
say "Sum is: $min_sum"
