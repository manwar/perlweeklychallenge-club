sub task2a ( @matrix --> Bool ) {
    # Map of first Non-Zero location in each row
    my @nz = @matrix».first(:k, * != 0);

    pop @nz while @nz and @nz.tail.defined.not;

    sub col_ok ($col) { @matrix».[$col].grep(* != 0).elems == 0|1 }

    # Given the @nz locations of first non-zero (having removed trailing all-zero rows):
    #   1. Are any rows left?
    #   2. No all-zero rows in the middle
    #   3. Movement is diagonal
    #   4. First non-zero is always 1 (as opposed to e.g. 2, π, 42, etc. )
    #   5. Each first-non-zero's whole column is zero (except the 1)
    return ?(
            @nz
        and @nz».defined.all
        and [<] @nz
        and @nz.pairs.map({ @matrix[ .key ; .value ] }).all == 1
        and @nz.keys».&col_ok.all
    );
}

# Adapted from my original (2011) code at https://rosettacode.org/wiki/Reduced_row_echelon_form#Row_operations,_procedural_code
sub reduced-row-echelon-form ( @input_matrix ) {
    my @M = @input_matrix.map(*.clone); # `@M` directly modified by the four subs.

    sub    scale-row ( \scale, \r       ) { @M[r]  =              @M[r]  »×» scale   }
    sub    shear-row ( \scale, \r1, \r2 ) { @M[r1] = @M[r1] »+» ( @M[r2] »×» scale ) }
    sub   reduce-row (         \r,  \c  ) { scale-row( 1/@M[r;c], r) }
    sub clear-column (         \r,  \c  ) { shear-row  -@M[$_;c], $_, r for @M.keys.grep: * != r }

    @M .= sort({ .first(:k, * != 0) // Inf });

    my $column-count = @M[0].elems;
    my $col = -1;
    for @M.keys -> $row {
        $col++;
        last if $col == $column-count;
        redo if @M[$row;$col] == 0;

          reduce-row( $row, $col );
        clear-column( $row, $col );
    }
    return @M.map(*.list».narrow);
}
# Now the task can become: convert the matrix to RREF form, and see if it matches the original.
sub task2b ( @matrix --> Bool ) {
    return @matrix.Seq eqv reduced-row-echelon-form(@matrix);
}


my @subs = 
    :&task2a,
    :&task2b,
;
use Test; plan @subs * my @tests =
    ( 0, ( <1 1 0>      , <0 1 0>     , <0 0 0>                   ) ),
    ( 1, ( <0 1 -2 0 1> , <0 0 0 1 3> , <0 0 0 0 0> , <0 0 0 0 0> ) ),
    ( 1, ( <1 0 0 4>    , <0 1 0 7>   , <0 0 1 -1>                ) ),
    ( 0, ( <0 1 -2 0 1> , <0 0 0 0 0> , <0 0 0 1 3> , <0 0 0 0 0> ) ),
    ( 0, ( <0 1 0>      , <1 0 0>     , <0 0 0>                   ) ),
    ( 0, ( <4 0 0 0>    , <0 1 0 7>   , <0 0 1 -1>                ) ),
;
for @subs -> ( :key($sub_name), :value(&task2) ) {
    for @tests -> ( $expected, @in ) {
        my @in_numeric = @in.map: +«* ;
        is task2(@in_numeric), ?$expected, "$sub_name @in[0]";
    }
}
