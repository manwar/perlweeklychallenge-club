#!/usr/bin/env raku

my $example = q:to/END/.chomp;
x * * * x * x x x x
* * * * * * * * * x
* * * * x * x * x *
* * * x x * * * * *
x * * * x * * * * x
END

multi sub MAIN("test") is hidden-from-USAGE {
    my $expected = q:to/END/.chomp;
    x 1 0 1 x 2 x x x x
    1 1 0 2 2 4 3 5 5 x
    0 0 1 3 x 3 x 2 x 2
    1 1 1 x x 4 1 2 2 2
    x 1 1 3 x 2 0 0 1 x
    END

    use Test;

    is parse-mines( "x*x" ), [["x","*","x"]];
    is parse-mines( "x * x" ), [["x","*","x"]];
    is find-numbers( "x*x" ), "x 2 x";
    
    is find-numbers( $example ), $expected;

    done-testing;
}

#| Displays the exmaple grid
multi sub MAIN("example") {
    $example.say;
    ("-" x 19).say;
    find-numbers( $example ).say;
}

subset PInt of Int where * > 0;
subset Density of Int where 1 <= * <= 50;

#| Given a width, height and mine density (1-50%) makes a map then prints the numbers
multi sub MAIN( PInt $width, PInt $height, Density $density ) {
    my @opts = ( |("x" xx $density), |("*" xx (100-$density)) );
    my $grid = (^$height).map( { @opts.roll($width).join( " " ) } ).join("\n");
    $grid.say;
    ("-" xx $width).join("-").say;
    find-numbers( $grid ).say;
}

sub parse-mines( Str $input ) {
    return $input.lines.map( { $_.comb(/\S/).Array } ).Array;
}

sub find-numbers(Str $s) {
    my @grid = parse-mines( $s );

    my @surround = (1,0,-1) X, (1,0,-1);
    
    for 0..^@grid.elems -> $y {
        for 0..^@grid[$y].elems -> $x {
            next if @grid[$y][$x] ~~ 'x';
            my $count = 0;
            for @surround -> ($dy,$dx) {
                next if 0 ~~ $dy ~~ $dx;
                try { $count++ if @grid[$y+$dy][$x+$dx] ~~ 'x'; }
            }
            @grid[$y][$x] = $count;
        }
    }

    return @grid.map( { $_.join(" ") } ).join("\n");
}
