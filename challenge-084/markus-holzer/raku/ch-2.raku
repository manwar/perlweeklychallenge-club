unit sub MAIN( Bool :$size );

my @matrix[4,8] =
    < 1 1 0 1 1 1 0 1 >,
    < 1 1 0 0 1 1 0 0 >,
    < 0 1 1 1 0 1 1 1 >,
    < 1 0 1 1 1 0 1 1 >;

my ( $h, $w ) = @matrix.shape;
my @s = gather
    for [X] 0..^$h, 0..^$w -> ($r, $c) {
        for $r ^..^ $h -> $R {
            for $c ^..^ $w -> $C {
                take $r, $c, $R-$r, $C-$c if
                    @matrix[$R;$C] &&
                    @matrix[$R;$c] &&
                    @matrix[$r;$C] &&
                    @matrix[$r;$c] }}}

say "Row: {.[0]+1}, Column:{.[1]+1}, Size: {.[2]+1}x{.[3]+1}"
    for $size ?? @s.sort( *.[2,3] ) !! @s;

say "Total: {+@s}";
