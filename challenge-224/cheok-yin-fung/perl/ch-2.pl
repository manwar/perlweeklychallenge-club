use v5.30.0;
use warnings;
use List::Util qw/max/;

sub an {
    my $n = $_[0];
    for my $first (1..length($n)/2) {
        for my $second (1..length($n)/2) {
            my $x = substr($n, 0, $first);
            my $y = substr($n, $first, $second);
            my $sum = $first + $second;
            my @arr = ($x, $y);
            while ($sum < length $n) {
                my $z = $x+$y;
                push @arr, $z;
                $sum += length($z);
                $x = $y;
                $y = $z;
            }
            return 1 if ($n eq join "", @arr) && $#arr > 1;
        }
    }
    return 0;
}


use Test::More tests=>5;
ok an(112358);
ok !an(12345);
ok an(199100199);
ok an(199100199299);
ok !an(1564898);

