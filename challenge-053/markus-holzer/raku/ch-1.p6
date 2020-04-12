sub MAIN( Int $degrees where * %% 90, :$size = 3 )
{
    my @matrix[ $size, $size ]  = ( 1..$size² ).batch( $size );

    clockwise( @matrix ) for ^( $degrees / 90 );

    dd @matrix;
}

sub clockwise( @matrix )
{
    my $n = @matrix.elems;
    my $x = ( $n / 2 ).floor;
    my $y = $n - 1;
    
    for ^$x -> $i
    {
        for ^$y -> $j
        {
            my $dj = $y - $j;
            my $di = $y - $i;
            my $k  = @matrix[ $i; $j ];

            @matrix[ $i;  $j  ] = @matrix[ $dj; $i  ];
            @matrix[ $dj; $i  ] = @matrix[ $di; $dj ];
            @matrix[ $di; $dj ] = @matrix[ $j;  $di ];
            @matrix[ $j;  $di ] = $k;
        }
    }
};