my @matrix[4,4] =
    < 1 1 0 1 >,
    < 1 1 0 0 >,
    < 0 1 1 1 >,
    < 1 0 1 1 >;

my ( $h, $w ) = @matrix.shape;

# I had no idea min is also an infix until yesterdays review video
my @s = gather for [X] 0..^$h, 0..^$w, 1..$h min $w -> ($r, $c, $o) {
    take $r, $c, $o if
        $c + $o < $w &&               # check boundaries
        $r + $o < $h &&
        all @matrix[ $r+$o; $c+$o ],  # check corners
            @matrix[ $r+$o; $c ],
            @matrix[ $r; $c+$o ],
            @matrix[ $r; $c] }

say +@s;
"r: {.[0]+1}, c:{.[1]+1}, {.[2]+1}x{.[2]+1}".say for @s.sort(*.[2]);
