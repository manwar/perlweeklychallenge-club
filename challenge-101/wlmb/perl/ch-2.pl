#!/usr/bin/env perl
# Perl weekly challenge 101
# Task 2: Origin containing triangle
#
# See https://wlmb.github.io/2021/02/22/PWC101/#task-2-origin-containing-triangle
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);
use List::Util qw(all any pairs);
use Scalar::Util qw(looks_like_number);

sub usage {
    say "./ch-2.pl x1 y1 x2 y2 x3 y3\nChecks if origin in triangle (x1,y1)(x2,y2)(x3,y3)";
    exit 1;
}

sub cross {
    my ($A, $B)=@_;
    return $A->[0]*$B->[1]-$A->[1]*$B->[0];
}
usage() unless @ARGV==6 and all {looks_like_number $_} @ARGV;
my ($A, $B, $C)=pairs @ARGV;
my ($AB, $BC, $CA)=(cross($A,$B), cross($B,$C), cross($C,$A));
my $clockwise=all {$_>=0} ($AB, $BC, $CA);
my $counterclockwise=all {$_<=0} ($AB, $BC, $CA);
my $result=($clockwise||$counterclockwise)?1:0;
my $edge=any {$_==0} ($AB, $BC, $CA);
say "Input: ", join " ", map {"($_->[0],$_->[1])"} ($A, $B, $C);
say "Output: $result";
say "Since (0,0) is within the triangle" if $result and !$edge;
say "Since (0,0) is within an edge" if $result and $edge;
say "Since (0,0) is not within the triangle" unless $result;
