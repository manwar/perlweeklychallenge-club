sub MAIN( $n ) 
{
    say (1 .. Inf).map( *.base(2).Str ).first( * %% $n );
}
