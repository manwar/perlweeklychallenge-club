#!/usr/bin/env perl
# Perl weekly challenge 124
# Task 1:  Womans day
#
# See https://wlmb.github.io/2021/08/02/PWC124/#task-1-women-day

use warnings;
use strict;
use v5.12;
use PDL;
use utf8;

die 'Usage: ./ch-1.pl N Width Heigth LineWidth Char' unless @ARGV==5;
my ($N, $W, $H, $LW, $char)=@ARGV; # 2*$N+1 pixels, Width and Height of cross, linewidth, char
my $z=zeroes(2*$N+1, 2*$N+1);
my $r=$z->rvals; # distance to center of circle
my $x=$z->xvals-$N; #x,y coordinates with repect to top of cross
my $y=$z->yvals;
my $circle=$r<=$N&$r>=(1-$LW)*$N;
my $vertical=$y<=$H*(2*$N+1)&$x->abs<=$LW*$N/2;
my $horizontal=$x->abs<=$W*$N&($y-$H*$N)->abs<=$LW*$N/2;
my $cross=$horizontal|$vertical;
# (2N+1)x(4N+1) circle and cross, made of 1's and 0's, and some brackets
# (remove 1 row from circle for better join to cross)
my $venus=$circle->slice(':,:-2')->glue(1,$cross);
# stringify
my $venus_string=sprintf "%s", $venus;
# edit string replacing 0's, eliminating brakets and replacing 1's by desired character
$venus_string=~tr/0[]/ /d;
$venus_string=~s/1/$char/g;
say $venus_string;
