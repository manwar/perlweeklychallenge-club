#!raku

class Histogram {
    has Int $.column;
    has Int $.height;

    method Str() { "Histogram $!height Column $!column"; }
}


class Rectangle {
    has Int $.height;
    has Int $.base;

    method area() { $!height * $!base }
    method Str()  { "Rectangle with base $!base and height $!height ($!base x $!height)" }
}


sub MAIN( *@A
          where { @A.grep( * ~~ Int ).elems == @A.elems  && @A.grep( *.Int >= 1 ) } ) {
    say "Numbers are { @A }";

    my Histogram @histograms;
    my $column = 1;
    for @A {
        @histograms.push: Histogram.new: column => $column, height => $_.Int;
    }


    my Rectangle @rectangles;
    my ( $current-height, $current-width ) = Nil, Nil;

    for 0 ..^ @histograms.elems -> $current-index {
        ( $current-height, $current-width ) = @histograms[ $current-index ].height, 0;


        for 0 ..^ @histograms.elems {
            next if $_ < $current-index && @histograms[ $_ ].height < $current-height;
            if @histograms[ $_ ].height < $current-height {
                last;
            }
            else {
                $current-width++;
            }
        }

        @rectangles.push: Rectangle.new( height => $current-height,
                                         base => $current-width );
    }



    # get the first one with the biggest area
    @rectangles.sort( { $^b.area <=> $^a.area } ).first.put;


}
