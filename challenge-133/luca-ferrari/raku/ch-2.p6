#!raku


sub MAIN( Int $cols where { $cols > 0 } = 5, Int $rows where { $rows > 0 } = 3 ) {
    my @table;
    my @distinct;

    # table header
    "  x\t|\t".print;
    ( 1 .. $cols ).join( "\t" ).say;
    "--------|--------".print;
    ( "-" x 8 x $cols ).say;



    
    for 1 .. $rows -> $current-row {
        for 1 .. $cols -> $current-col {
            my $value = $current-row * $current-col;
            @table[ $current-row - 1 ].push: $value;
            @distinct.push: $value if ! @distinct.grep( $value );
        }
    }

    # print the table
    for 1 .. $rows {
        "  $_\t|\t".print;
        @table[ $_ - 1 ].join( "\t" ).say;
    }

    "\nDistinct values: ".say;
    @distinct.join( ', ' ).say;

}
