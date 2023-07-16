#!/usr/bin/env raku

sub max-words (+list) {
    list
    andthen .map: *.words.elems
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is max-words(
        'Perl and Raku belong to the same family.',
        'I love Perl.',
        'The Perl and Raku Conference.',
    ),
       8
    ;
    is max-words(
        'The Weekly Challenge.',
        'Python is the most popular guest language.',
        'Team PWC has over 300 members.',
    ),
       7
    ;
    done-testing;
};

multi MAIN (+list) {
    say max-words list
}
