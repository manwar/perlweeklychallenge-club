#!raku

sub MAIN( Int $top where { $top > 1 } ) {
    my @haystack = (1 xx $top, 2 xx $top / 2).flat;
    my @solutions;

    # get all possible combinations
    for @haystack.permutations {
        # check every sub-array that gives me the sum
        for 0 ..^ $_.elems -> $index {
            @solutions.push: $_[ 0 .. $index ]  if $_[ 0 .. $index ].sum == $top;
        }
    }


    # print only unique values
    say @solutions.unique: as => { .Str };
    
}

