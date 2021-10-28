use strict;
use warnings;
use feature "say";

sub gcd {
    my ($i, $j) = @_;
    return 0 if $i < 1 or $j < 1;
    while ($j) {
        ($i, $j) = ($j, $i % $j);
    }
    return $i;
}
sub is_friendly {
    my $gcd = gcd $_[0], $_[1];
    return 0 if $gcd <= 1;
    $gcd /= 2 while $gcd % 2 == 0;
    return $gcd == 1 ? 1 : 0;
}
for my $pair ([8, 24], [26, 39], [4, 10], [7, 5], [18, 0]) {
    say "@$pair => ", is_friendly @$pair;
}
