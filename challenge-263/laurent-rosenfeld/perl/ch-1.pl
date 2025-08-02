use strict;
use warnings;
use feature 'say';

sub find_index {
    my $target = shift;
    my @sorted = sort { $a <=> $b } @_;
    my @out = grep {$sorted[$_] == $target} 0..$#sorted;
    return "@out" || "()";
}

my @tests = ( [2, [1, 5, 3, 2, 4, 2]],
              [6, [1, 2, 4, 3, 5]],
              [4, [5, 3, 2, 4, 2, 1]] );
for my $test (@tests) {
    printf "%d - %-15s => ", $test->[0], "@{$test->[1]}";
    say find_index  @$test[0], @{$test->[1]};
}
