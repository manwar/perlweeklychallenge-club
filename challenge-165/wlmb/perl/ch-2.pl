#!/usr/bin/env perl
# Perl weekly challenge 165
# Task 2: Line of best fit
#
# See https://wlmb.github.io/2022/05/20/PWC165/#task-2-line-of-best-fit
use v5.12;
use warnings;
use PDL;
die 'Usage: ./ch-2.pl "[[x1,y1], [x2,y2]...]" to fit a set of points' unless @ARGV==1;
my $input=pdl($ARGV[0]);
my $N=$input->dim(1); # number of points
die 'Require more than one point' unless $N>1;
my $sum=$input->transpose->sumover;
my ($sum_x, $sum_y)=$sum->list;
my $sum_2=($input**2)->transpose->sumover; # sum of squares
my ($sum_x_2, $sum_y_2)=$sum_2->list;
my $sum_xy=$input->prodover->sumover; # sum of xy
my $det=$N*$sum_x_2-$sum_x**2;
die "Singular system" if $det==0;
my $slope=($N*$sum_xy-$sum_x*$sum_y)/$det;
my $intercept=($sum_x_2*$sum_y-$sum_x*$sum_xy)/$det;
say join ",", @$_ for @{$input->unpdl}; # output points
my $x=$input->slice("(0)"); # x coords
my ($y0, $y1)=map {$slope*$_+$intercept} (my ($x0,$x1)=($x->minimum,$x->maximum));
say "$x0, $y0, $x1, $y1";
