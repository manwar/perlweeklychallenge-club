use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my $size = shift() - 1;
my @matrix;
for my $i (0..$size) {
    for my $j (0..$size-1) {
        if ($i == $j) {
            $matrix[$i][$j] = 1;
        } else {
            $matrix[$i][$j] = 0;
        }
    }
}
say Dumper \@matrix;
