#!/usr/bin/env raku

#| Given a sorted list of integers output a list of lists of sequential values
sub MAIN( *@vals where *.all ~~ Int() ) {
    @vals.reduce(
        -> $v1 is copy, $v2 {
            if $v1 ~~ Int(Str) {
                $v1 = [[$v1],]
            }
            if $v1[*-1][*-1] ~~ $v2-1 {
                $v1[*-1].push($v2)
            } else {
                $v1.push( [ $v2, ] )
            }
            $v1
        }).say;
}
