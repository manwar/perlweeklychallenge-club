#!raku


class HashTable {
    # hash of the table
    has Int $.size = 2;

    method !doMatch( @memory, @S, $r-index, $s-index ) {
        for @memory -> $rr {
            for @S -> $s {
                say $rr.join( ' ' ) ~ $s[ 0 .. $s-index - 1, $s-index + 1 .. * - 1 ],join( ' ' )  if $s[ $s-index ] ~~ $rr[ $r-index ];
            }
        }

        @memory = ();
    }

    method match( @R, @S, Int $r-index = 0, Int $s-index = 0 ) {
        my @memory;
        for @R -> $r {
            @memory.push: $r;
            self!doMatch( @memory, @S, $r-index, $s-index )  if @memory.elems == $!size;
        }

        self!doMatch( @memory, @S, $r-index, $s-index ) if @memory;
    }
}

sub MAIN() {
    my  @player_ages = 
    [20, "Alex"  ],
    [28, "Joe"   ],
    [38, "Mike"  ],
    [18, "Alex"  ],
    [25, "David" ],
    [18, "Simon" ],
    ;

    my  @player_names = 
        ["Alex", "Stewart"],
        ["Joe",  "Root"   ],
        ["Mike", "Gatting"],
        ["Joe",  "Blog"   ],
        ["Alex", "Jones"  ],
        ["Simon","Duane"  ],
    ;

    my $hash = HashTable.new;
    $hash.match( @player_ages, @player_names, 1, 0 );
}
