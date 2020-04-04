multi sub MAIN( Int $N, :$l )
{
    my $start  = now;
    my @result = Array.new( Any, 1, :shape( $N + 1 ) );

    for 1..$N -> $n
    {
        my $current = 0;
        my $next    = $n;
        my $cached;
        loop
        {
            # Dynamic programming:
            # see what you have computed so far, so you
            # don't have to compute it again
            $cached = @result[ $next ];
            last if $cached;

            $next = $next %% 2 ?? $next / 2 !! $next * 3 + 1;
            $current++;
        }

        @result[ $n ] = [ $n, $current + $cached ];
    }

    say "n: { .[0] }, length: { .[1] }" for
        @result
            .skip
            .sort( -*[1] )
            .head(20);

    say "runtime: { now - $start } seconds";
}

multi sub MAIN( Int $n, :$s )
{
    say collatz( $n ).join( ',' );
}

sub collatz( Int $n )
{
    $n, { $^n %% 2 ?? $^n / 2 !! $^n * 3 + 1 } ... { $^n == 1 }
}
