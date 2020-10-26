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

say +@s;
"r: {.[0]+1}, c:{.[1]+1}, {.[2]+1}x{.[3]+1}".say for @s; #.sort( *.[2,3] );
