#!/usr/bin/env raku
use SVG;
use Data::Dump;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-165/
# Least Squares Regression
# https://www.mathsisfun.com/data/least-squares-regression.html

sub MAIN( Str $datafile where .IO ~~ :e  = './ch2.data'){
    my @dots;

    my $svg = svg => [];

    my Int $sum_x;
    my Int $sum_y;
    my Int $sum_xy;
    my Int $sum_xx;
    my Int $max_x = 0;
    my Int $max_y = 0;
    my Int $N = 0;

    for $datafile.IO.lines -> $line {
        my @points = $line.split(/\s+/,:skip-empty).map: {[.split(",").map: {.Int}]};
        for @points -> @p {
            $N++;
            my ($x, $y) = @p;
            $max_x  =  $x if $x > $max_x;
            $max_y  =  $y if $y > $max_y;
            $sum_x  += $x;
            $sum_y  += $y;
            $sum_xy += $x * $y;
            $sum_xx += $x**2;
            my $circle = circle => [:cx($x.Int), :cy($y.Int), :r(3), :fill('black')];
            $svg.<svg>.push: $circle;
        }
    }

    my $width  = $max_x + 30;
    my $height = $max_y + 30;
    $svg.<svg>.push: :width( $width );
    $svg.<svg>.push: :height( $height );
    my $text = text => [:x(10), :y($height), 'Challenge 165 #2'];
    $svg.<svg>.push: $text;

    my $slope = (
            $N * $sum_xy - $sum_x * $sum_y
        ) / (
            $N * $sum_xx - $sum_x**2
        );

    my $y_int = ($sum_y - $slope * $sum_x) / $N;
    
    # Find y value for max x value
    my $y_max_x = $slope * $max_x + $y_int;

    # Draw line from ( 0, y_int) and ( max_x, y @ max_x)
    my $line = line => [
            :x1(0),
            :y1($y_int),
            :x2($max_x),
            :y2($y_max_x),
            :style("stroke:rgb(255,0,0);stroke-width:2")
        ];
    $svg.<svg>.push: $line;

    say SVG.serialize($svg);
}

