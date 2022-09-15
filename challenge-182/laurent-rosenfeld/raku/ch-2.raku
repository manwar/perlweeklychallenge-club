my @input = qw <
    /a/b/c/1/x.pl
    /a/b/c/d/e/2/x.pl
    /a/b/c/d/3/x.pl
    /a/b/c/4/x.pl
    /a/b/c/d/5/x.pl
    >;

my @paths = gather {
    for @input <-> $line {
        $line ~~ s/^'/'//;
        my @subpaths = split /'/'/, $line;
        take @subpaths[0..*-2];
    }
}
my $end = @paths.end;
my $k = 0;
OUTLOOP: for 0..(@paths[0].end) -> $i {
    for 0..$end -> $j {
        if @paths[$j][$i]:!exists or @paths[$j][$i] ne @paths[0][$i] {
            $k = $i - 1;
            last OUTLOOP;
        }
    }
}
say '/', join '/', @paths[0][0..$k];
