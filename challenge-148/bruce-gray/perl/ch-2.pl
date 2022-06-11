use Modern::Perl;
use experimental qw<signatures>;

# See README for analysis common to Perl and Raku.

# Uses WolframAlpha solution for `c`.
# Empty return if c would be non-integer, otherwise aref of all three.
sub find_Cardano_triplet ( $x, $y ) {
    my $m = ($x + 1)**2 * (8*$x - 1);
    my $n = 27 * $y * $y;

    return if $m % $n;
    return [ $x, $y, $m / $n ];
}

# Locking b=1, to use a humorous definition of "first 5".
say sprintf('%3d %3d %3d', @{$_}) for map { find_Cardano_triplet( (3 * $_ + 2, 1), ) } 0..4;
