use strict;
use warnings;

sub concatenation_value {
    my @ints = @_;
    my $concat_value = 0;
    while (@ints) {
        if (@ints == 1) {
            $concat_value += $ints[0];
            shift @ints;
        }
        else {
            my $first = $ints[0];
            my $last = $ints[-1];
            my $concat = "$first$last";
            $concat_value += $concat;
            shift @ints;
            pop @ints;
        }
    }
    return $concat_value;
}

# Tests
use Test::More;

is(concatenation_value(6, 12, 25, 1), 1286, "Example 1");
is(concatenation_value(10, 7, 31, 5, 2, 2), 489, "Example 2");
is(concatenation_value(1, 2, 10), 112, "Example 3");

done_testing();
