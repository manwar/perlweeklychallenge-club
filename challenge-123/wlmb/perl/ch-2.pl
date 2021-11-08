#!/usr/bin/env perl
# Perl weekly challenge 123
# Task 2: Square points
#
# See https://wlmb.github.io/2021/07/27/PWC123/#task-2-square-points
use strict;
use warnings;
use v5.12;
use PDL;
foreach(@ARGV){
    # assume data as strings "[[x0,y0],[x1,y1],[x2,y2],[x3,y3]]"
    my $m=pdl($_); # convert to 2d array
    # Separate into four vectors, translate the origin to the first
    # and sort by size
    my $v0=$m->slice(":,(0)");
    my (undef, $s1, $s2, $d)=sort {size2($a) <=> size2($b)} map {$_-$v0} $m->dog;
    # $s1 and $s2 ought to be the sides and $d the diagonal
    # check they add up and their sizes. I use 'approx' to accommodate rounding errors.
    my $ok=approx(size2($s1+$s2-$d),0) && approx(size2($s1),size2($s2))
           && approx(size2($d),2*size2($s1));
    say "Input: $m Output: $ok"
}
sub size2 { #  squared size of vector
    my $v=shift @_;
    return ($v*$v)->sumover;
}
