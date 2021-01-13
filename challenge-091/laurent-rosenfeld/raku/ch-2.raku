use v6;

my @tests = [ <1 2 1 2 > ], [ < 2 1 1 0 2 > ], [ < 1 2 1 2 1 > ];
say $_, " -> ", jump $_ for @tests;

sub jump (@in) {
    my $i = 0;
    loop {
        return 0 unless @in[$i];
        my $next_i = $i + @in[$i];
        return 1 if $next_i == @in.end;
        return 0 if $next_i > @in.end;
        $i = $next_i;
    }
}
