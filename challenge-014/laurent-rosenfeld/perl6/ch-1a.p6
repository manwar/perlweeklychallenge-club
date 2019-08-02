use v6;

sub MAIN ( UInt $max ) {
    my @a = lazy gather {
        take 0;
        for 0..* -> $n {
            my $result = 0;
            for reverse ^$n -> $m {
                $result = $n - $m and last if @a[$m] == @a[$n];
            }
            take $result;
        }
    }
    say join " ", @a[0..$max];
}
