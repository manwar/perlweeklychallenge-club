use experimental :cached;

unit sub MAIN( Int $N where * > 0, Bool :$v = False );

my $start = now;

with my @combinatons = gather combine zeckendorf $N
{
    say @combinatons.map( *.join( "," ) ).join( "\n" ) if $v;
    say "# of combinations: {+@combinatons}";
    say "Calculated in { sprintf "%.3f", now - $start } seconds"
}

sub combine( @Z ) is cached
{
    my &valid  = -> $result {
        $result.elems == $result.unique.elems && $result !~~ @Z };

    my &insert = -> $where, $what {
        my @x = @Z.clone; @x.splice( $where, 1, |$what ); @x };

    take @Z;

    sink @Z
        .map( &zeckendorf )
        .kv.map( &insert )
        .grep( &valid )
        .map( &combine )
}

sub zeckendorf( $n is copy ) is cached
{
    state @fib = [1, 1, * + * ... * > $N];

    my &do-zeckendorf = {
        eager gather for @fib.grep( * < $n ).reverse {
            if $_ <= $n {
                take $_;
                $n -= $_; }}}

    $n == 1 ?? 1.List !! do-zeckendorf
}