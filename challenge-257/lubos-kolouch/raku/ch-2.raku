sub is-reduced-row-echelon(@matrix) {
    my $last-leading = -1;
    my $zero-row-encountered = False;

    for @matrix.kv -> $row-index, @row {
        my $leading = -1;

        for @row.kv -> $i, $element {
            if $element != 0 {
                $leading = $i;
                last if $element == 1;
                return 0;  # First non-zero element is not 1
            }
        }

        if $leading == -1 {
            $zero-row-encountered = True;
            next;
        }

        if $zero-row-encountered {
            return 0;  # Non-zero row after zero row
        }

        if $leading <= $last-leading {
            return 0;  # Leading 1 in the wrong position
        }

        for @matrix -> @r {
            next if @r === @row;
            return 0 if @r[$leading] != 0;
        }

        $last-leading = $leading;
    }

    return 1;
}

# Test cases
use Test;
is is-reduced-row-echelon([ [1, 1, 0], [0, 1, 0], [0, 0, 0] ]), 0, "Test 1";
is is-reduced-row-echelon([ [0, 1, -2, 0, 1], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0] ]), 1, "Test 2";
is is-reduced-row-echelon([ [1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1] ]), 1, "Test 3";
is is-reduced-row-echelon([ [0, 1, -2, 0, 1], [0, 0, 0, 0, 0], [0, 0, 0, 1, 3], [0, 0, 0, 0, 0] ]), 0, "Test 4";
is is-reduced-row-echelon([ [0, 1, 0], [1, 0, 0], [0, 0, 0] ]), 0, "Test 5";
is is-reduced-row-echelon([ [4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1] ]), 0, "Test 6";

done-testing;
