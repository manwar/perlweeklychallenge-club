use strict;
use warnings;
use feature "say";

my @matrix = ( [  1,  2,  3,  5,  7 ],
               [  9, 11, 15, 19, 20 ],
               [ 23, 24, 25, 29, 31 ],
               [ 32, 33, 39, 40, 42 ],
               [ 45, 47, 48, 49, 50 ]
             );

sub A2AoA {
    my $index = shift;
    my ($i, $j) = (int $index / 5, $index % 5);
}
sub bin_search {
    my $in = shift;
    my ($min, $max) = (0, 24);
    while ($max > $min) {
        my $pivot =  int (($max + $min) /2);
        my ($i, $j) = A2AoA $pivot;
        my $val = $matrix[$i][$j];
        # say "val = $val, $i, $j";
        return 1 if $val == $in;
        if ($in > $val) {
            $min = $pivot + 1;
        } else {
            $max = $pivot;
        }
    }
    return 0;
}
say "$_ => ", bin_search $_ for 0..54;
