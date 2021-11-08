use strict;
use warnings;
use feature qw/say/;

sub bin2dec {
    my $bin = shift;
    my $sum = 0;
    for my $i (split //, $bin) {
        $sum = $sum * 2 + $i;
    }
    return $sum;
}

sub invert_bit {
    my ($m, $n) = @_;
    my $bin = sprintf "%08b", $m;
    # say $bin;
    my $bit = substr $bin, -$n, 1;
    substr $bin, -$n, 1, $bit == 0 ? 1 : 0;
    # say $bin;
    return bin2dec $bin;
}
for my $pair ( [12, 3], [18, 4], [249, 1] ) {
    say "@$pair => ", invert_bit @$pair;
}
