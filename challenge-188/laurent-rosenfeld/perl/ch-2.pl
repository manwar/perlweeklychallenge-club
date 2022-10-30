use strict;
use warnings;
use feature qw/say/;

sub to_zero  {
    my ($x, $y) = @_;
    return $x >= $y ? ($x - $y, $y) : ($x, $y - $x);
}

for my $test ([5, 4], [4, 6], [2, 5], [3, 1], [7, 4], [9, 1]) {
    my ($x, $y) = @$test;
    my $count = 0;
    while ($x and $y ) {
        ($x, $y) = to_zero $x, $y;
        $count++;
    }
    say "@$test -> $count";
}
