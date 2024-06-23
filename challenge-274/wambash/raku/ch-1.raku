#!/usr/bin/env raku

subset VowelWord where *.starts-with: <a e i o u>.any;

multi rot-word (VowelWord $word) {
    $word
}

multi rot-word ($word) {
    $word.subst: /(\w)(\w+)/, {$1 ~ $0}
}

sub goat-latin ($sentance) {
    $sentance.wordcase:  filter => {  .&rot-word ~ 'ma' ~ 'a' x ++$ }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is rot-word('love'), 'ovel';
    is rot-word('and'),  'and';
    is goat-latin('I love Perl'), 'Imaa ovelmaaa erlPmaaaa';
    is goat-latin('Perl and Raku are friends'), 'erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa';
    is goat-latin('The Weekly Challenge'), 'heTmaa eeklyWmaaa hallengeCmaaaa';
    done-testing;
}

multi MAIN ($sentance) {
    say goat-latin $sentance
}
