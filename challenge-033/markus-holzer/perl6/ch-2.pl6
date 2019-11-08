# this works for all n

sub MAIN( $n = 11 )
{
    my $ln = ($n * $n).Str.chars + 1;
    my $li = $n.chars + 1;

    header( $n );
    line( $_, $n ) for ( 1 .. $n );

    sub line( $i, $n )
    {
        my @n = ( ( $i .. $n ) X* $n ).map({ sprintf( "%{$ln}s", $_ ) });
        my @e = ( ' ' xx ($ln * ($i - 1) ) );
        say sprintf( "%{$li}s", $i), "|", @e.join,  @n.join;
    }

    sub header( $n )
    {
        my @h = ( 1 .. $n ).map({ sprintf("%{$ln}s", $_ ) });
        say sprintf( "%{$li}s", "x" ), "|", @h.join;
        say ( "-" xx $li ).join, "+", ( '-' xx ( $n * $ln ) ).join;
    }

}