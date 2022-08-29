#!/usr/bin/env raku

multi sub MAIN() is hidden-from-USAGE {
    use Test;
    is trim-below(3, (1,4,2,3,5)), (4,5);
    is trim-below(4, (9,0,6,2,3,8,5)), (9,6,8,5);
    done-testing;
}

#| Given an integer and a list of number return the list with all the numbers less than or equal to the value removed
multi sub MAIN(
    Int() \v, #= Target value
    *@list #= List of numbers
) {
    say trim-below( v, @list );
}

sub trim-below( Int \v, @list ) {
    return @list.grep( * > v ).List;
}
