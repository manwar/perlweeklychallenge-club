use strict;
use warnings;
use feature 'say';

sub sum {
    my $sum = 0;
    $sum += $_ for @_;
    return $sum;
}

sub sum_of_values {
    my ($k, @in) = @_;
    my @eligibles = map { $in[$_] }
        grep {sprintf ("%b", $_) =~ tr/1/1/  == $k} 0..$#in;
    return sum @eligibles;
}

my @tests = ( [1, [<2 5 9 11 3>]],
              [2, [<2 5 9 11 3>]],
              [0, [<2 5 9 11 3>]] );

for my $test (@tests) {
    printf "%-3s - %-15s  => ", "$test->[0]", "@{$test->[1]}";
    say sum_of_values $test->[0], @{$test->[1]};
}
