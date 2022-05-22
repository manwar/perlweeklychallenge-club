use strict;
use warnings;
##
# Plot lines and points in SVG format. 
##
sub svg_begin{
    return <<BEGIN;
        <?xml version="1.0" encoding="UTF-8" standalone="yes"?>                                   <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">                                                                          <svg height="100%" width="100%" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
BEGIN
}

sub svg_end{
    return "</svg>";
}

sub svg_point{
    my($x, $y) = @_;
    return "<circle cx=\"$x\" cy=\"$y\" r=\"1\" />";
}

sub svg_line{
    my($x0, $y0, $x1, $y1) = @_;
    return "<line x1=\"$x0\" x2=\"$x1\" y1=\"$y0\" y2=\"$y1\" />";          
}

sub svg{
    my @lines = @_;
    my $svg = svg_begin;
    for my $line (@_){
        $svg .= svg_point(@{$line}) if @{$line} == 2;
        $svg .= svg_line(@{$line})  if @{$line} == 4;
    }
    return $svg . svg_end;
}


MAIN:{
    my @lines;
    while(<DATA>){
        chomp;
        push @lines, [split(/,/, $_)];
    }
    print svg(@lines);
}


__DATA__
53,10
53,10,23,30
23,30
