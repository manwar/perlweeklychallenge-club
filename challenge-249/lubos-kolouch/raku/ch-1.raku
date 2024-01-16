use Test;

sub equal-pairs(@ints) {
    my %freq = @ints.Bag;

    # Check if all elements have even frequency
    return [] if %freq.values.any(* % 2);

    # Form pairs
    my @pairs;
    for %freq.kv -> $num, $count {
        @pairs.append([$num, $num]) for 1..($count div 2);
    }

    return @pairs;
}

# Tests
plan 2;
is-deeply equal-pairs(3, 2, 3, 2, 2, 2), [[2, 2], [2, 2], [3, 3]], 'Example 1';
is-deeply equal-pairs(1, 2, 3, 4), [], 'Example 2';

done-testing;
