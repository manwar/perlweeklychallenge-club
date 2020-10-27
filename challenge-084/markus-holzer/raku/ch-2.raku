unit sub MAIN( Bool :$size );

#my @matrix[4,4] =
#    < 0 1 0 1 >,
#    < 0 0 1 0 >,
#    < 1 1 0 1 >,
#    < 1 0 0 1 >;

my @matrix[4,4] =
    < 1 1 0 1 >,
    < 1 1 0 0 >,
    < 0 1 1 1 >,
    < 1 0 1 1 >;

#my @matrix[4,8] =
#    < 1 1 0 1 1 1 0 1 >,
#    < 1 1 0 0 1 1 0 0 >,
#    < 0 1 1 1 0 1 1 1 >,
#    < 1 0 1 1 1 0 1 1 >;


my ( $h, $w ) = @matrix.shape;

my @squares = gather
    for 0 .. $h - 2 -> $r {
        for 0 .. $w - 2 -> $c {
            if @matrix[ $r; $c ] {
                for 1 .. -1 + min $h - $r, $w - $c -> $o {
                    take $r, $c, $o if
                        @matrix[ $r+$o; $c+$o ] &&
                        @matrix[ $r+$o; $c ]    &&
                        @matrix[ $r; $c+$o ]    }}}}

@squares = @squares.sort: *.[ 2, 3 ]
    if $size;

say "Row: { .[0] }, Column:{ .[1] }, Size: { .[2] }x{ .[2] }"
    for @squares.map: 1 «+« *;

say "Total: { +@squares }";