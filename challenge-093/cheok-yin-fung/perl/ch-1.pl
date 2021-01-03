#!/usr/bin/perl
# The Weekly Challenge 093
# Task 1 Max Points
use strict;
use warnings;
use List::Util qw/max/;
use Test::More tests => 2 ;

my @coordinates = ([1,1], [2,2], [3,1], [1,3], [5,3] );

sub max_points {
    my $max = 1;
    my @line_char = @_;
    my $count = 1;
    my $pre = shift @line_char;
    for (@line_char) {
        if ($_ != $pre) {
            $max = $count if $count > $max;
            $pre = $_;
            $count = 1;
        } else {
            $count++;
        }
    }
    $max = $count if $count > $max;
    return $max;
}

sub max_colinear_points {
    my @coord = @_;
    my @nw_line_char = sort {$a<=>$b} map {$_->[0]+$_->[1]} @coord;
    my @ne_line_char = sort {$a<=>$b} map {$_->[0]-$_->[1]} @coord;
    my @ver_line_char = sort {$a<=>$b} map {$_->[1]} @coord;
    my @hor_line_char = sort {$a<=>$b} map {$_->[0]} @coord;

    print "\n";
    return max  max_points(@nw_line_char),max_points(@ne_line_char),
            max_points(@hor_line_char), max_points(@ver_line_char);
}


ok (max_colinear_points([3,5],[2,4],[3,4],[4,4],[1,3],[2,3],[3,3],
    [4,3],[5,3],[2,2],[3,2],[4,2],[3,1]) == 5,  "Test Case diamond " );

ok (max_colinear_points([1,1],[2,2],[3,3]) == 3, "Example 1");
