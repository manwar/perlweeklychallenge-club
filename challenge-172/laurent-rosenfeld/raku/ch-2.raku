sub median (@in) { # input values must have been sorted
    my $count = @in.elems;
    if $count %% 2 {
        return (@in[$count/2 -1] + @in[$count/2])/2;
    } else {
        return @in[($count - 1) / 2];
    }
}
sub summary (@input) {
    my @in = sort @input;
    my $min = @in[0];
    my $max = @in[*-1];
    my $median = median(@in);
    my $first-quart = median( grep { $_ < $median}, @in);
    my $third-quart = median( grep { $_ > $median}, @in);
    return $min, $first-quart, $median, $third-quart, $max;
}
my @moons = 0, 0, 1, 2, 63, 61, 27, 13;
say summary(@moons);
