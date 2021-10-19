#!/usr/bin/env raku

#| Given a pair of integers m and n draw a mulitplication grid and count the number of unique numbers
sub MAIN( UInt \m, UInt \n ) {
    my \max-width = ( m*n ).codes;
    my \max-val = (m,n).max;
    my @seen;

    # Header
    say (sprintf '%*s ', max-width, 'x') ~ "|" ~ (1..m).map( { sprintf "%*s", max-width, $_ } ).join(' ');
    # Divider
    say ('-' x max-width + 1) ~ ( ('-' x max-width + 1) x m );
    # Rows
    for (1..n) -> \i {
        my @row = (1..m).map( { $_ * i } );
        push @seen, |@row;
        say (sprintf '%*s ', max-width, i) ~ '|' ~ @row.map( {  sprintf "%*s", max-width, $_ } ).join(' ');
    }
    my \distinct = @seen.Set;
    say 'Distinct Terms: ' ~ distinct.keys.sort.join(', ');
    say 'Count: ' ~  distinct.elems;
}
