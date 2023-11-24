use Test;

sub count-smaller(@nums) {
    return gather for 0 ..^ @nums.elems -> $i {
        take (0 ..^ @nums.elems).grep({ @nums[$_] < @nums[$i] && $_ != $i }).elems;
    }
}

# Tests
is-deeply count-smaller(8, 1, 2, 2, 3), [4, 0, 1, 1, 3], 'Example 1';
is-deeply count-smaller(6, 5, 4, 8), [2, 1, 0, 3], 'Example 2';
is-deeply count-smaller(2, 2, 2), [0, 0, 0], 'Example 3';

done-testing;
