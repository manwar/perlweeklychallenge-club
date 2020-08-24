#!raku

class Histogram {
    has Int $.column;
    has Int $.height;

    method Str() { "Histogram $!height Column $!column"; }
}


class Rectangle {
    has Int $.height;
    has Int $.base;

    has Range $.columns;

    method area() { $!height * $!base }
    method Str()  { "Rectangle with base $!base and height $!height ($!base x $!height) {$!columns}" }
}


sub graph( Histogram :@histograms, Rectangle :$rectangle? ) {
    my @lines;
    my $max-height = max @histograms.map( { .height } );


    while ( $max-height > 0 ) {
        my @line;
        @line.push: $max-height ~ '| ';

        for @histograms {
            my $column = .column;
            my $height = .height;
            my $to-print = $rectangle
            && $column ~~ $rectangle.columns
            && $rectangle.height >= $max-height
            ?? ' X' !! ' #';
            @line.push: .height >= $max-height ?? $to-print !! '  ';
        }

        @lines.push: @line.join;
        $max-height--;
    }

    @lines.push: '---' x @histograms.elems;
    @lines.push: '    ' ~ @histograms.map( { .column } ).join( ' ' );
    @lines;
}


sub MAIN( *@A
          where { @A.grep( * ~~ Int ).elems == @A.elems  && @A.grep( *.Int >= 1 ) } ) {
    say "Numbers are { @A }";

    my Histogram @histograms;
    my $column = 1;
    for @A {
        @histograms.push: Histogram.new: column => $column++, height => $_.Int;
    }


    my Rectangle @rectangles;
    my ( $current-height, $current-width ) = Nil, Nil;
    my ( $start-column, $end-column )      = Nil, Nil;

    for 0 ..^ @histograms.elems -> $current-index {
        ( $current-height, $current-width ) = @histograms[ $current-index ].height, 0;
        ( $start-column, $end-column ) = $current-index + 1 , $current-index + 1;


        # go backwards to the first histogram that has a good height
        my $starting-index = $current-index;
        while ( $starting-index > 0 &&  @histograms[ $starting-index ].height >= $current-height ) {
            $starting-index--;
        }

        for $starting-index ..^ @histograms.elems {
            next if $_ < $current-index && @histograms[ $_ ].height < $current-height;
            if @histograms[ $_ ].height < $current-height {
                last;
            }
            else {
                $current-width++;
                $start-column = min $_ + 1 , $start-column;
                $end-column   = max $_ + 1, $end-column;
            }
        }

        @rectangles.push: Rectangle.new( height => $current-height,
                                         base => $current-width,
                                         columns => $start-column .. $end-column  );
    }



    # get the first one with the biggest area
    my Rectangle $biggest = @rectangles.sort( { $^b.area <=> $^a.area } ).first;
    $biggest.put;

    # try to print the histogram
    "Following is the graph of the histogram".say;
    graph( histograms => @histograms, rectangle => $biggest ).join( "\n" ).say;

}
