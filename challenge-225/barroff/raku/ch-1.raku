#!/usr/bin/env raku

use v6.d;

sub max-words(Str:D @words --> Int) {
    # max(map({($_ ~~ m:g/<wb> ( \s ) <wb>/).elems}, @words)) + 1;
    # max(map({($_ ~~ m:g/<|w> ( \s ) <|w>/).elems}, @words)) + 1;
    max(map({($_ ~~ m:g/>> ( \s ) <</).elems}, @words)) + 1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is max-words(Array[Str:D].new(('Perl and Raku belong to the same family.',
                'I love Perl.',
                'The Perl and Raku Conference.'))),
        8, 'works for first sentence list';
    is max-words(Array[Str:D].new(('The Weekly Challenge.',
                'Python is the most popular guest language.',
                'Team PWC has over 300 members.'))),
        7, 'works for second sentence list';
}

#| Take user provided list like Perl Rust Raku
multi sub MAIN(*@words where @words.elems ≥ 1) {
    my Str @str-words = @words;
    say max-words(@str-words);
}

