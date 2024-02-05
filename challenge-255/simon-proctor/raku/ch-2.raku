#!/usr/bin/env raku

multi sub MAIN('test') {
    use Test;
    is next-most-frequent(phrase => 'Joe hit a ball, the hit ball flew far after it was hit.', banned => 'hit'), 'ball';
    is next-most-frequent(phrase => 'Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.', banned => 'the'), 'Perl'; 
    done-testing;
}

multi sub MAIN($banned, *@words) {
    next-most-frequent( phrase => @words.join(' '), :$banned ).say;
}

sub next-most-frequent(:$phrase, :$banned) {
    $phrase.words.map( { .trans(["a".."z","A".."Z"] => "", :complement) } ).grep({ $_ ne $banned }).Bag.antipairs.sort({$_.key}).reverse.first.value;
}

