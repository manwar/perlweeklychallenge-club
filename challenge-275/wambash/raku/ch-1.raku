#!/usr/bin/env raku

sub broken-keys ($sentence,+@keys) {
    $sentence
    andthen .words
    andthen .grep: { .fc.contains: none @keys».fc }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is broken-keys('Perl Weekly Challenge',    <l a>), 0;
    is broken-keys('Perl and Raku',            <a>),   1;
    is broken-keys('Well done Team PWC',       <l o>), 2;
    is broken-keys('The joys of polyglottism', <T>),   2;
    done-testing;
}

multi MAIN ($sentence,+@keys) {
    say broken-keys $sentence, @keys
}
