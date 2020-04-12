my Int $hits = 0;
my Int $miss = 0;

multi sub MAIN( Int $N, :$s )
{
    my ($n, @c) = collatz( $N );
    say "n: $n, length: { @c.elems }";
    say @c.join( ',' );
}

multi sub MAIN( Int $N, :$l )
{
    my $start  = now;
    my %result;

    for 1..$N -> $n
    {
        my Int $count = 0;
        my Int $cache = 0;

        my @new = gather for collatz( $n ) -> $collatz
        {
            # Dynamic programming:
            # see what you have computed so far, so you
            # don't have to compute it again
            if %result{ $collatz }:exists
            {
                $hits += $cache = %result{ $collatz };
                last;
            }

            $miss++;
            take $collatz, $count++;
        }

        %result{ .[0] } = @new.elems - .[1] + $cache
            for @new;
    }

#    say "halftime: { now - $start } seconds";

    say "n: { .key }, length: { .value - 1 }" for
            %result
            .grep( *.key   < $N )
            .sort( *.value * -1 )
            .head(20);

    say "runtime: { now - $start }";
    say "cache misses: $miss, cache hits: $hits";
}

sub collatz( Int $n ) is pure
{
    $n, { $^n %% 2 ?? $^n div 2 !! $^n * 3 + 1 } ... { $^n == 1 }
}