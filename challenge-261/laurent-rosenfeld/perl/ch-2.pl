use strict;
use warnings;
use feature 'say';

sub multiply_by_two {
    my $start = shift;
    die "$start cannot be 0" if $start == 0;
    my %present = map { $_ => 1 } @_;
    $start *= 2 while $present{$start};
    return $start;
}

my @tests = ( [3, [5,3,6,1,12]], [1, [1,2,4,3]], [2, [5,6,7]] );
for my $test (@tests) {
    printf "%d - %-15s => ", $test->[0], "@{$test->[1]}";
    say multiply_by_two @$test[0], @{$test->[1]};
}
