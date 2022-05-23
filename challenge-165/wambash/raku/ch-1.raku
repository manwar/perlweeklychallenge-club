#!/usr/bin/env raku

role SVG {
    method svg () {
        '<'
        ~ self.^name.gist.lc
        ~ ' '
        ~ self.Capture.hash.sort.map( { .key ~ '=' ~ '"' ~ .value ~ '"' } )
        ~ ' '
        ~ '/>'
    }
}

class Circle does SVG {
    has $.cx;
    has $.cy;
    has $.r = 2;
    has $.fill = 'orange';
}

class Line does SVG {
    has $.x1;
    has $.y1;
    has $.x2;
    has $.y2;
    has $.stroke= 'blue';
    has $.stroke-width = 1;
}

sub svg ( +@svg, :$height = 400, :$width = 600 ) {
    sprintf( q:to/END/
<svg
version="1.1"
xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink"
height="%d" width="%d"
>
END
, $height, $width)
    ~ @svg».svg.fmt( "\t%s", "\n" )
    ~ "\n"
    ~ '</svg>'
}

multi to-point-line (+@ ($cx, $cy) ) {
    Circle.new: :$cx, :$cy
}

multi to-point-line (+@ ($x1, $y1, $x2, $y2)) {
    Line.new: :$x1, :$y1, :$x2, :$y2
}

multi MAIN (Int :$height = 400,Int :$width = 600 ) {
    words()
    andthen .map: *.split: ','
    andthen .map: &to-point-line
    andthen svg $_, :$height, :$width
    andthen .say
}

multi MAIN (Bool :test($)!) {
    use Test;
    with to-point-line 23,10 {
        isa-ok $_, Circle;
        is (.cx,.cy),(23,10);
        is .svg, '<circle cx="23" cy="10" fill="orange" r="2" />';
    }
    with to-point-line 53,12, 23,10 {
        isa-ok $_, Line;
        is (.x1,.y1),(53,12);
        is (.x2,.y2),(23,10);
        is .svg, '<line stroke="blue" stroke-width="1" x1="53" x2="23" y1="12" y2="10" />';
    }
    done-testing;
}
