#!/usr/bin/env raku

sub h-index ( +@citation ) {
    @citation
    andthen 0, |$_
    andthen .reduce: { $^count < $^n ?? $^count+1 !! last }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is h-index(10,8,5,4,3), 4;
    is h-index(25,8,5,3,3), 3;
    is h-index(10 xx 20),   10;
    is h-index(9...1),      5;
    is h-index(9,7,6,2,1),  3;
    done-testing;
}

multi MAIN ( *@citation ) {
    say h-index  @citation
}
