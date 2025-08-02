use strict;
use warnings;
use feature 'say';

sub maximum_ones {
    my @mat = @_;
    my $max = 0;
    my $max_i;
    for my $i (0..$#mat) {
        my $sum = 0;
        $sum += $_ for @{$mat[$i]};
        if ($sum > $max) {
            $max = $sum;
            $max_i = $i;
        }
    }
    return $max_i + 1;
}

my @tests = ( [ [0, 1], [1, 0] ],
              [ [0, 0, 0], [1, 0, 1] ],
              [ [0, 0], [1, 1], [0, 0] ] );
for my $test (@tests) {
    printf "%-8s, %-8s, ... => ",
        "[@{$test->[0]}]", "[@{$test->[1]}]";
    say maximum_ones @$test;
}
