use strict;
use warnings;
use feature qw/say/;

sub find_frequent_int {
    my %histo;
    %histo = map { $_ => ++$histo{$_} }
             grep { $_ % 2 == 0 } @_;
    return -1 if scalar %histo < 1;
    return ( sort { $histo{$b} <=> $histo{$a}
                    || $a <=> $b } keys %histo)[0];
}
for my $test ([<1 1 2 6 2>], [<1 3 5 7>], [<6 4 4 6 1>],
    [<8 4 8 6 4 6>], [<8 4 8 6 4 6 8>], [<6 4 8 6 4 6 8>]) {
    say "@$test => ", find_frequent_int @$test;
}
