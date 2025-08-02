sub task1_single_expression (@matrix) {
    return @matrix».grep( :k, 1 )
                   .grep( *.elems == 1 )
                   .map(  *.head )
                   .Bag
                   .grep( *.value == 1 )
                   .elems;
}
sub task1_original (@matrix) {
    my BagHash $bh .= new;
    for  @matrix.kv -> $row_num, @row  {
        my $col_found;
        for @row.kv -> $col_num, $cell {
            if $cell == 1 {
                if $col_found.defined {
                    $col_found = Nil;
                    last;
                }
                $col_found = $col_num;
            }
        }
        if $col_found.defined {
            $bh{$col_found}++;
        }
    }
    return $bh.grep(*.value == 1).elems;
}
# Reducing by step-wise refactoring until we reach the single-expression version
sub task1_original_reduced_1 (@matrix) {
    my BagHash $bh .= new;
    for @matrix -> @row  {
        my @ones_locations = @row.grep(:k, 1);
        $bh{ @ones_locations.head }++ if @ones_locations.elems == 1;
    }
    return $bh.grep(*.value == 1).elems;
}
sub task1_original_reduced_2 (@matrix) {
    my BagHash $bh .= new;
    for @matrix.map( *.grep(:k, 1) ) -> @ones_locations  {
        $bh{ @ones_locations.head }++ if @ones_locations.elems == 1;
    }
    return $bh.grep(*.value == 1).elems;
}
sub task1_original_reduced_3 (@matrix) {
    my @column_numbers = gather for @matrix.map( *.grep(:k, 1) ) {
        take .head if .elems == 1;
    }
    my Bag $b .= new(@column_numbers);
    return $b.grep(*.value == 1).elems;
}
sub task1_original_reduced_4 (@matrix) {
    my @column_numbers = @matrix.map( *.grep(:k, 1) ).grep(*.elems == 1).map(*.head);
    return @column_numbers.Bag.grep(*.value == 1).elems;
}
sub task1_original_reduced_5 (@matrix) {
    return @matrix.map( *.grep(:k, 1) ).grep(*.elems == 1).map(*.head).Bag.grep(*.value == 1).elems;
}


constant @subs =
    :&task1_single_expression,
    :&task1_original,
    :&task1_original_reduced_1,
    :&task1_original_reduced_2,
    :&task1_original_reduced_3,
    :&task1_original_reduced_4,
    :&task1_original_reduced_5,
;
constant @tests =
    ( 1, ( (1, 0, 0), (0, 0, 1), (1, 0, 0) ) ),
    ( 3, ( (1, 0, 0), (0, 1, 0), (0, 0, 1) ) ),
;
use Test; plan +@tests * +@subs;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ($expected, @matrix) {
        is task1(@matrix), $expected, "$sub_name : @matrix[]";
    }
}
