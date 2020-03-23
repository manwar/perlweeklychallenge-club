multi sub MAIN( Int:D $degrees where * ~~ 90|180|270|360 )
{
    my @matrix[ 3, 3 ] = ( 1..9 ).batch( 3 );
    my $times       = $degrees / 90;

    clockwise( @matrix ) for ^$times;

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
            my $k = @matrix[ $i; $j ];

            @matrix[ $i;  $j  ] = @matrix[ $dj; $i  ];
            @matrix[ $dj; $i  ] = @matrix[ $di; $dj ];
            @matrix[ $di; $dj ] = @matrix[ $j;  $di ];
            @matrix[ $j;  $di ] = $k;
        }
    }
};