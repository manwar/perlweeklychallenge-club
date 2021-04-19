#!/usr/bin/env raku

#| Given a list of numbers a through g find a result where a+b == b+c+d == d+e+f == f+g
sub MAIN ( *@values where @values.elems == 7 && @values.all ~~ IntStr && [!==] @values.sort) {
    my @res = @values.permutations.first( -> @v { [==] (@v[0]+@v[1] , @v[1]+@v[2]+@v[3], @v[3]+@v[4]+@v[5], @v[5]+@v[6]) } );
    
    if ( ! defined @res[0] ) {
	say "Can't find a solution";
    } else {
	say "{@res[0]} + {@res[1]} = {@res[0] + @res[1]}";
	say "{@res[1]} + {@res[2]} + {@res[3]} = {@res[1] + @res[2] + @res[3]}";
	say "{@res[3]} + {@res[4]} + {@res[5]} = {@res[3] + @res[4] + @res[5]}";
	say "{@res[5]} + {@res[6]} = {@res[5] + @res[6]}";
    }
    
}
