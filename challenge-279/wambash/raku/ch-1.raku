#!/usr/bin/env raku

sub sort-letters (@letters,@weights) {
    @weights Z, @letters
    andthen .map: { IntStr.new: |$_ }\
    andthen .sort
    andthen .join
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sort-letters(<R E P L>, (3,2,1,4)),'PERL';
    is sort-letters(<A U R K>, (2,4,1,3)),'RAKU';
    is sort-letters(<O H Y N P T>, (5, 4, 2, 6, 1, 3)),'PYTHON';
    done-testing;
}

multi MAIN ($letters,*@weights) {
    say sort-letters $letters.comb, @weights
}
