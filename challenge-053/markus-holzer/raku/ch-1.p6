multi sub infix:<times>( Int $n, Callable $b --> Nil  ) is looser(&infix:<+>) { &$b($_) for ^$n; }
multi sub infix:<times>( Numeric $n, Callable $b  --> Nil ) is looser(&infix:<+>) { &$b($_) for ^($n.Int); }

sub MAIN( Int $degrees where * %% 90, :$size = 3 )
{
    my @matrix[ $size, $size ] = ( 1..$size² ).batch( $size );

    $degrees / 90 times { @matrix.&clockwise };

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