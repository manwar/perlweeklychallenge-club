use strict;
use warnings;
use Test::More;

sub find_neither_min_max {
    my @ints = @_;

    my ($min, $max) = (sort {$a <=> $b} @ints)[0,-1];
    my @result;

    foreach my $num (@ints) {
        if ($num != $min && $num != $max) {
            push @result, $num;
        }
    }

    return @result ? @result : -1;
}

# Test cases
is_deeply([find_neither_min_max(3, 2, 1, 4)], [3, 2], "Example 1");
is_deeply([find_neither_min_max(3, 1)], [-1], "Example 2");
is_deeply([find_neither_min_max(2, 1, 3)], [2], "Example 3");

done_testing();
