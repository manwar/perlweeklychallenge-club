unit sub MAIN( Bool :$size );

my @matrix[4,8] =
    < 1 1 0 1 1 1 0 1 >,
    < 1 1 0 0 1 1 0 0 >,
    < 0 1 1 1 0 1 1 1 >,
    < 1 0 1 1 1 0 1 1 >;

my ( $h, $w ) = @matrix.shape;

my @squares = gather
    for [X] 0..^$h, 0..^$w -> ( $r, $c ) {
        for $r ^..^ $h -> $R {
            for $c ^..^ $w -> $C {
                take $r, $c, $R-$r, $C-$c if
                    @matrix[ $R;$C ] &&
                    @matrix[ $R;$c ] &&
                    @matrix[ $r;$C ] &&
                    @matrix[ $r;$c ] }}}

@squares = @squares.sort( *.[2,3] )
    if $size;

say "Row: {.[0]}, Column:{.[1]}, Size: {.[2]}x{.[3]}"
    for @squares.map: 1 «+« *;

say "Total: {+@squares}";