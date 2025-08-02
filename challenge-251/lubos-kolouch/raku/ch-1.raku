sub concatenation-value(@ints where .all ~~ Int) returns Int {
    my $concat-value = 0;
    while @ints {
        if @ints == 1 {
            $concat-value += @ints[0];
            @ints.shift;
        }
        else {
            my $first = @ints[0];
            my $last = @ints[*-1];
            my $concat = "$first$last".Int;
            $concat-value += $concat;
            @ints.shift;
            @ints.pop;
        }
    }
    return $concat-value;
}

# Tests
use Test;
plan 3;

is concatenation-value([6, 12, 25, 1]), 1286, "Example 1";
is concatenation-value([10, 7, 31, 5, 2, 2]), 489, "Example 2";
is concatenation-value([1, 2, 10]), 112, "Example 3";
