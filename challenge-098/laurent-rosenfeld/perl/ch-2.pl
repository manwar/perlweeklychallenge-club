use strict;
use warnings;
use feature "say";

my @tests = ( [3,  qw < 1  2  3  4>],
              [6,  qw < 1  3  5  7>],
              [10, qw <12 14 16 18>],
              [19, qw <11 13 15 17>],
            );
for my $test (@tests) {
    say "$test->[0], @{$test}[1..@{$test}-1]: ", find_insert_pos ($test);
}
sub find_insert_pos {
    my ($target, @array) = @{$_[0]};
    for my $i (0..$#array) {
        return $i if $array[$i] >= $target;
    }
    return $#array + 1;
}
