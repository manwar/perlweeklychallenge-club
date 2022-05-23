#!/usr/bin/env raku
use SVG;

sub MAIN( Str $datafile where .IO ~~ :e  = './ch1.data'){

    my $svg = svg => [
        :width(300),
        :height(100),
        :text(:x(10),:y(80),'Challenge 165 #1'),
    ];

    for $datafile.IO.lines -> $line {
        my @p = $line.split(",",:skip-empty);
        if @p.elems == 4 {
            my ($x1, $y1, $x2, $y2) = @p;
            my $line = line => [
                    :x1($x1),
                    :y1($y1),
                    :x2($x2),
                    :y2($y2),
                    :style("stroke:rgb(0,0,0);stroke-width:2")
                ];
            $svg.<svg>.push: $line;
        } elsif @p.elems == 2 {
            my ($x, $y) = @p;
            my $circle = circle => [:cx($x.Int), :cy($y.Int), :r(5), :fill('red')];
            $svg.<svg>.push: $circle;
        }
    }
    
    say SVG.serialize($svg);
}

