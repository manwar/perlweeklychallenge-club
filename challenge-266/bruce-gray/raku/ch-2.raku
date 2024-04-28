# Walk the matrix once, noting by coordinate whether the cell
# is on either of the diagonals.
# Early return on first cell containing the wrong (zero/non-zero) value.
sub task2_efficient ( @mat --> Bool ) {
    die "Ill-defined for matrix of size zero" unless @mat.elems;
    die "Not square" unless @mat.elems == @mat».elems.all;

    for     @mat.kv -> $i, @row  {
        for @row.kv -> $j, $cell {

            my \is_zero = $cell == 0;

            my \is_diag = $i-$j == 0
                       || $i+$j == @row.end;

            return False if  is_diag and  is_zero
                         or !is_diag and !is_zero;
        }
    }

    return True;
}

# Pre-calculate all the coordinates of diagonal and anti-diagonal cells.
# The `unique` removes the doubled coordinate that occurs in the very center of odd-sized matrixes.
# The `sort` is critical when the use of these coordinates is to modify any row in the bottom half of the matrix.
sub diagonals_i_j ( $size ) {
    return (^$size).map({ |(($_, $_), ($_, $size - 1 - $_)) })
                   .unique( :with(&[eqv]) )
                   .sort;
}

# Find all (i,j) coordinates that are non-zero, and check that they exactly match the diagonals.
sub task2_concise ( @m --> Bool ) {
    return diagonals_i_j(+@m) eqv sort grep ->(\i,\j) { @m[i][j] !== 0 }, [X] @m.keys xx 2;
}

# Clone the matrix, extract the diagonal and anti-diagonal cells from each row and store in a seperate array, then check that all diags are non-zero and the remaining matrix cells are all zero.
sub task2_copy ( @matrix --> Bool ) {
    die "Ill-defined for matrix of size zero" unless @matrix.elems;
    die "Not square" unless @matrix.elems == @matrix».elems.all;

    my @m = @matrix.map({[ .list ]}); # Mutable copy

    # Using gather/take instead of `map` for clarity; @m is mutated in the loop.
    my @diag_values = gather for diagonals_i_j(+@m).reverse -> (\i,\j) {
        take @m[i].splice(j, 1).head;
    }

    return ?(  @diag_values.none == 0
              and @m»<>.flat.all == 0 );
}
# There are several hybrids of task2_copy that I did not code here:
#   * Early return during the `gather for` loop.
#   * Setting `@m[i][j]` to `0` after `take`, instead of `.splice`-ing it out.
#       Using `0` would also remove the `.sort` in diagonals_i_j(), and `.reverse` in its call.


constant @tests =
    ( 'Task example 1', True, (
        (1, 0, 0, 2),
        (0, 3, 4, 0),
        (0, 5, 6, 0),
        (7, 0, 0, 1),
    )),
    ( 'Task example 2', False, (
        (1, 2, 3),
        (4, 5, 6),
        (7, 8, 9),
    )),
    ( 'Task example 3', True, (
        (1, 0, 2),
        (0, 3, 0),
        (4, 0, 5),
    )),

;
constant @subs =
    :&task2_efficient,
    :&task2_concise,
    :&task2_copy,
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( $test_name, $expected, @matrix ) {
        is task2(@matrix), $expected, "$sub_name : $test_name";
    }
}
