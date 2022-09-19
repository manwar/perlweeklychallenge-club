use strict;
use warnings;
use feature "say";

sub is_esthetic {
    my @d = split //, shift;     # get an array of digits
    for my $i (1..$#d) {
        return 0 if abs($d[$i] - $d[$i -1 ]) != 1;
    }
    return 1;
}
for my $test (qw<5456 120 121 23456 2346 7654567 765467>) {
    say sprintf("%-9d", $test), is_esthetic($test) ? "is esthetic" : "is not esthetic";
}
