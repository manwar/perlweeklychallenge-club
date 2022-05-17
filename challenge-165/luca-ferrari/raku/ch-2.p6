#!raku

# Perl Weekly Challenge 165

sub MAIN() {

    my @input-points =
                <333,129  39,189 140,156 292,134 393,52  160,166 362,122  13,193
                 341,104 320,113 109,177 203,152 343,100 225,110  23,186 282,102
                 284,98  205,133 297,114 292,126 339,112 327,79  253,136  61,169
                 128,176 346,72  316,103 124,162  65,181 159,137 212,116 337,86
                 215,136 153,137 390,104 100,180  76,188  77,181  69,195  92,186
                 275,96  250,147  34,174 213,134 186,129 189,154 361,82  363,89 >;

    # "decompose" the input into two elements arrays
    my @points = @input-points.split( / \s+ / ).split( ',' ).split( / \s+ / ).map( *.Int ).rotor: 2;


    # compute all the parts
    my ( $m, $x, $y, $xy, $xx ) = 0,0,0,0,0;
    $x  = [+] @points.map( { $_[0] } );
    $y  = [+] @points.map( { $_[1] } );
    $xy = [+] @points.map( { $_[0] * $_[1] } );
    $xx = [+] @points.map( { $_[0] ** 2 } );
    $m  = ( @points.elems * $xy - $x * $y ) / ( @points.elems * $xx - $x ** 2 );

    my $b = 0;
    $b = ( $y - $m * $x ) / @points.elems;

    # compute the line start and end point
    my @line;
    @line.push: $_, $m * $_ + $b for 0,100;


    # now I need to graph
    my $task1 = run "raku", <raku/ch-1.p6 task2.svg>, :in, :err;
    $task1.in.say: $_.join( ',' ) for @points;
    $task1.in.say: @line.join( ',' );
    $task1.in.close;
    $task1.err.slurp.say;
}
