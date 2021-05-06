use v6;

my @matrix = (  1,  2,  3,  5,  7 ),
             (  9, 11, 15, 19, 20 ),
             ( 23, 24, 25, 29, 31 ),
             ( 32, 33, 39, 40, 42 ),
             ( 45, 47, 48, 49, 50 );

sub A2AoA ($index) {
    my ($i, $j) = $index.polymod(5).reverse;
}
sub binary ($in) {
    my ($min, $max) = 0, 24;
    while $max > $min {
        my $pivot = (($max + $min) /2).Int;
        my ($i, $j) = A2AoA $pivot;
        my $val = @matrix[$i][$j];
        # say "val = $val, $i, $j";
        return 1 if $val == $in;
        if $in > $val {
            $min = $pivot + 1;
        } else {
            $max = $pivot;
        }
    }
    return 0;
}
say "$_ => ", binary $_ for 0..54;
