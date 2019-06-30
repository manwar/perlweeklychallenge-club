use v6;

my @a = 0,;
for ^20 -> $n {
    my $result = 0;
    for reverse ^$n -> $m {
        $result = $n - $m and last if @a[$m] == @a[$n];
            # Note: $m is always smaller than $n, so $n - $m > 0
    }
    push @a, $result;
}
say @a;
