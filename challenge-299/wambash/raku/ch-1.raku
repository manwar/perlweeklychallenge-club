#!/usr/bin/env raku

sub replace-words ($sentence, +@words) {
    $sentence.subst: /  « <@words> <( \w+ /, :d:g #)>
}

multi MAIN (Bool :test($)!) {
    use Test;
    is replace-words('the cattle was rattle by the battery', 'cat', 'rat', 'bat'),'the cat was rat by the bat';
    is replace-words('aab aac and cac bab', <a b c>), 'a a a c b';
    is replace-words('the manager was hit by a biker', <man bike>), 'the man was hit by a bike';
    is replace-words('the manager was hit by a motobiker', <man bike>), 'the man was hit by a motobiker';
    done-testing;
}

multi MAIN ($sentence, +words) {
    say replace-words $sentence, words
}
