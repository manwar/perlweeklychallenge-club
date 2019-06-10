use v6;

sub prettify (@matrix) {
    return join "\n", map { join " ", $_}, @matrix;
}
sub MAIN (Int $size where * > 0) {
    my @matrix = map { my $i = $_; map { $i == $_ ?? 1 !! 0 },
        0..$size },  0..$size;
    say prettify @matrix;
}
