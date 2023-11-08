sub missing-members(@iarr1, @iarr2) {
    my @set-difference12 = (@iarr1 (-) @iarr2).keys;
    my @set-difference21 = (@iarr2 (-) @iarr1).keys;
    my @result;
    if @set-difference12.elems > 0 {
        @result.push(@set-difference12);
    }
    if @set-difference21.elems > 0 {
        @result.push(@set-difference21);
    }
    return @result;
}
