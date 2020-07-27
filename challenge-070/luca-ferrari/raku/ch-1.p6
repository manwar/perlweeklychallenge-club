#!raku


sub MAIN( Str $S,
          Int $C where { $C >= 1 },
          Int $O where { $O >= 1 && $O >= $C && ( $C + $O ) <= $S.chars } ) {
    my $N = $S.chars;

    say "$S with $N chars, swap counter $C and offset $O";

    my @chars = $S.split( '', :skip-empty );
    for 1 .. $C {
        my ( $index-left, $index-right ) = $_ % $N, ( $_ + $O ) % $N;
        ( @chars[ $index-left ], @chars[ $index-right ] ) = @chars[ $index-right ], @chars[ $index-left ];
    }

    @chars.join.say;
}
