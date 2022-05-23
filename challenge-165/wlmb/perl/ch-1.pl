#!/usr/bin/env perl
# Perl weekly challenge 165
# Task 1: Scalable vector graphics (svg)
#
# See https://wlmb.github.io/2022/05/20/PWC165/#task-1-scalable-vector-graphics-svg
use v5.12;
use warnings;
use SVG;

# Parameter definitions
my $relative_radius=0.01; # size of point vs. canvas size
my $relative_width=0.005; # width of stroke vs. canvas size
my $absolute_size=400; # absolute size of canvas
my $fill="red"; # fill color
my $stroke="blue"; # stroke color

# Initialize svg object
my $svg=SVG->new(width=>$absolute_size, height=>$absolute_size);

# make group for transforming coordinates
my $g=$svg->group();

my @bbox; # required bounding box
while(<>){ # read input
    chomp;
    my @coords=split /\s*,\s*/; # interpret as comma separated coordinates
    # two coordinates for point, four for line
    die "Expected x,y or x1,y1,x2,y2 coordinates" unless @coords==2 || @coords==4;
    $g->circle(cx=>$coords[0], cy=>$coords[1], fill=>$fill) if @coords==2;
    $g->line(x1=>$coords[0],y1=>$coords[1],x2=>$coords[2],y2=>$coords[3], stroke=>$stroke)
        if @coords==4;
    adjust_bbox(@coords[(0,1)]); # acomodate bounding box to new coordinates
    adjust_bbox(@coords[(2,3)]);
}
my ($Lx, $Ly)=($bbox[2]-$bbox[0], $bbox[3]-$bbox[1]); # Get size of canvas in user coords.
$Lx||=1; # default size
$Ly||=1;
my $L=$Lx>$Ly?$Lx:$Ly; # make square canvas
my $radius=$relative_radius*$L; # radius of point
my $width=$relative_width*$L; # and stroke width in user coords
my $scale=$absolute_size/($L+2*$radius); # scale user to canvas coords
for(0,1){ # enlarge bounding box to accommodate radius of points at extremes
    $bbox[$_]-=$radius;
    $bbox[$_+2]=$bbox[$_]+$L+2*$radius;
}
# set radius of all circles
$_->setAttribute("r", $radius) for $g->getElements("circle");
# set stroke widths of all lines
$_->setAttribute("stroke-width", $width) for $g->getElements("line");
# set a coordinate transformation from user to canvas coordinates.
$g->setAttribute("transform", "scale($scale, -$scale) translate(".-$bbox[0].",".-$bbox[3].")");
say $svg->xmlify; # output the svg code

sub adjust_bbox { # enlarge the bounding box to accommodate a point
    my ($x, $y)=@_;
    return unless defined $x and defined $y;
    for ([0, $x, 1], [1, $y, 1], [2, $x, -1], [3, $y, -1]){
	my ($i,$z, $s)=@$_;
	$bbox[$i]=$z if !defined $bbox[$i] or $s*$z<$s*$bbox[$i];
    }
}
