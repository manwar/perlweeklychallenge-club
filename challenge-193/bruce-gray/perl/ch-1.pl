use v5.36;

sub task1 ($n) {
    my @r = ('');

    @r = (  map("0$_", @r),
            map("1$_", @r)  ) for 1..$n;

    return @r;
}

say join " ", task1($_) for 0..3;
