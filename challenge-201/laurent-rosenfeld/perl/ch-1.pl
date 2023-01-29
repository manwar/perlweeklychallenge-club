use strict;
use warnings;
use feature "say";

sub find_missing {
    my %in = map {$_ => 1} @_;
    return grep { not exists $in{$_} } 0..scalar @_;
}
for my $test ([0, 1, 3], [0, 1], [0, 1, 3, 5, 7, 2]) {
    printf "%-15s => ", "@$test";
    say map "$_ ", find_missing @$test;
}
