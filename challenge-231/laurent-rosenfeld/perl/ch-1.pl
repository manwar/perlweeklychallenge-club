use strict;
use warnings;
use feature 'say';

sub find_min_max {
    my $min = my $max = $_[0];
    for my $val (@_) {
        $min = $val if $val < $min;
        $max = $val if $val > $max;
    }
    return ($min, $max);
}

sub min_max {
    my ($min, $max) = find_min_max(@_);
    my @vals = grep {$_ != $min && $_ != $max} @_;
    return @vals ? @vals : (-1);
}

for my $test ([<3 2 1 4>], [<3 1>], [<2 1 3>]) {
    printf "%-10s => ", "@$test";
    say join " ", min_max @$test;
}
