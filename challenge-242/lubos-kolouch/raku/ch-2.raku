use Test;

sub flip-matrix(@matrix) {
    return @matrix.map({ [($_.reverse).map({1 - $_})] });
}

# Corrected Test cases
is-deeply flip-matrix(([1, 1, 0], [1, 0, 1], [0, 0, 0])), (([1, 0, 0], [0, 1, 0], [1, 1, 1])), 'Example 1';
is-deeply flip-matrix(([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])), (([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])), 'Example 2';

done-testing;
