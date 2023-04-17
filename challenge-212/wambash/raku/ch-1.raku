#!/usr/bin/env raku
enum Alphabet (<a> .. <z>);

sub jumping-letters ($word,+@jump) {
    $word
    andthen .samemark('a').samecase('a')
    andthen .subst: / (.) /, {
        .( (::{$0} + @jump[$++]) mod 26 )  without Alphabet
    }, :g
    andthen  .samemark($word).samecase($word)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is jumping-letters('Perl',2,22,19,9),'Raku';
    is jumping-letters('Raku',24,4,7,17),'Perl';
    done-testing;
}

multi MAIN ($word,*@jump) {
    say jumping-letters $word,@jump
}
