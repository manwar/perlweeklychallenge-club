#!/usr/bin/env perl
# Perl weekly challenge 391
# Task 2:  Arrange Box
#
# See https://wlmb.github.io/2026/09/14/PWC391/#task-2-arrange-box
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S0 S1...
    to find how many boxes in Sn may be nested.
    Sn is a string of space separated pairs of numbers "P0 P1..."
    where each pair Pn is of the form width,height
    FIN
for(@ARGV){
    my @box =
        sort {by_nesting_height_width($a, $b)}
        map { [ split(","),1] }    # [width, height, nesting]
        split " ";
    for my $small(1..@box-1){
        my $bsmall=$box[$small];
        for my $large(0..$small-1){
            next unless fits($bsmall, $box[$large]); # find fitting box w/largest nesting
            $bsmall->[2] = $box[$large]->[2]+1;      # update nesting level
	    my $newplace = $small;                   # find where to move box
            for (0..$small-1){                       # to keep list sorted
                $newplace = $_, last
                    if by_nesting_height_width($bsmall, $box[$_])==-1;
            }
            splice @box, $small, 1;
            splice @box, $newplace, 0, $bsmall;
            last;
        }
    }
    say "$_ -> $box[0]->[2]"; # nesting level of first box
}
sub by_nesting_height_width($x, $y) {
    $y->[2] <=> $x->[2]      # compare nesting
        || $y->[1]<=>$x->[1] # height
        || $y->[0]<=>$x->[0]  # width
}
sub fits($x,$y){
    $x->[0] < $y->[0] && $x->[1] < $y->[1] # compare width and height
}
