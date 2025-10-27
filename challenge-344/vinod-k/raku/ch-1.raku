use v6;
use Test;

sub add-to-array-form (
    @ints is raw,
    Int $x
) returns List {
    my $int-form = @ints.join('').Int;
    my $sum = $int-form + $x;
    return $sum.Str.comb.map(*.Int).Array;
}

# Testing

sub MAIN {
    plan 5;

    my @ints1 = (1, 2, 3, 4);
    my $x1 = 12;
    my @expected1 = (1, 2, 4, 6);
    is-deeply add-to-array-form(@ints1, $x1), @expected1,
        "Test 1: (1,2,3,4) + 12 should be (1, 2, 4, 6)";

    my @ints2 = (2, 7, 4);
    my $x2 = 181;
    my @expected2 = (4, 5, 5);
    is-deeply add-to-array-form(@ints2, $x2), @expected2,
        "Test 1: (2, 7, 4) + 181 should be (4, 5, 5)";

    my @ints3 = (9, 9, 9);
    my $x3 = 1;
    my @expected3 = (1, 0, 0, 0);
    is-deeply add-to-array-form(@ints3, $x3), @expected3,
        "Test 1: (9, 9, 9) + 1 should be (1, 0, 0, 0)";

    my @ints4 = (1, 0, 0, 0, 0);
    my $x4 = 9999;
    my @expected4 = (1, 9, 9, 9, 9);
    is-deeply add-to-array-form(@ints4, $x4), @expected4,
        "Test 1: (1, 0, 0, 0, 0) + 9999 should be (1, 9, 9, 9, 9)";

    my @ints5 = (0);
    my $x5 = 1000;
    my @expected5 = (1, 0, 0, 0);
    is-deeply add-to-array-form(@ints5, $x5), @expected5,
        "Test 1: (0) + 12 should be (1, 0, 0, 0)";
}
