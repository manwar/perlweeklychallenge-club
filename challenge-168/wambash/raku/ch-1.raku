#!/usr/bin/env raku
constant @perrin-seq = 3, 0, 2, -> $a, $b, $ { $a+$b } ... *;
constant @perrin-prime = @perrin-seq.skip.grep( *.is-prime).unique;

sub perrin-prime ($head = 13) {
    @perrin-prime.head: $head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is @perrin-seq.head(8), (3, 0, 2, 3, 2, 5, 5, 7,);
    is perrin-prime(13), (2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193, 792606555396977);
    done-testing;
}

multi MAIN ($head = 13) {
    put perrin-prime $head
}
