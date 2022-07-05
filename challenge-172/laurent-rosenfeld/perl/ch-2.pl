use strict;
use warnings;
use feature "say";

sub median {
    my @in = @_; # Input values have been sorted previously
    my $count = scalar @in;
    if ($count % 2) {
        return $in[($count - 1) / 2];
    } else {
        return ($in[$count/2 -1] + $in[$count/2])/2;
    }
}
sub summary {
    my @in = sort { $a <=> $b } @_;
    my $min = $in[0];
    my $max = $in[-1];
    my $median = median(@in);
    my $first_quart = median( grep { $_ < $median} @in);
    my $third_quart = median( grep { $_ > $median} @in);
    return $min, $first_quart, $median, $third_quart, $max;
}
my @moons = (0, 0, 1, 2, 63, 61, 27, 13);
say join " ", summary(@moons);
