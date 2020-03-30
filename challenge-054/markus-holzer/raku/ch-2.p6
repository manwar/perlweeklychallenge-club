sub MAIN( Int $N )
{
    my $start  = now;
    my %result = 1 => 1;

    for 1..$N -> $n
    {
        my $current = 0;
        my $next    = $n;

        loop
        {
            # Dynamic programming:
            # see what you have computed so far, so you
            # don't have to compute it again
            %result{ $n } = %result{ $next } and last
                if %result{ $next };

            $next = $next %% 2 ?? $next / 2 !! $next * 3 + 1;
            $current++;
        }

        %result{ $n } += $current;
    }

    say "n: $_, length: %result{ $_ }" for
        %result
            .keys
            .sort({ %result{ $^b } <=> %result{ $^a } })
            .head( 20 );

    say "runtime: { now - $start } seconds";
}

