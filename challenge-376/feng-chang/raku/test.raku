#!/bin/env raku

# The Weekly Challenge 376
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Chessboard Squares
pwc-test './ch-1.raku', <a7 f4>, 'True',  'Chessboard Squares: $c1="a7",$c2="f4" => true';
pwc-test './ch-1.raku', <c1 e8>, 'False', 'Chessboard Squares: $c1="c1",$c2="e8" => false';
pwc-test './ch-1.raku', <b5 h2>, 'False', 'Chessboard Squares: $c1="b5",$c2="h2" => false';
pwc-test './ch-1.raku', <f3 h1>, 'True',  'Chessboard Squares: $c1="f3",$c2="h1" => true';
pwc-test './ch-1.raku', <a1 g8>, 'False', 'Chessboard Squares: $c1="a1",$c2="g8" => false';

# Task 2, Doubled Words
pwc-test './ch-2.raku',
    "you're given the job of checking the pages on a\\nweb server for doubled words (such as 'this this'), a common problem\\nwith documents subject to heavy editing.",
    "web server for doubled words (such as '[this] [this]'), a common problem",
    'Doubled Words: test 1';
pwc-test './ch-2.raku',
    "Find doubled words despite capitalization differences, such as with 'The\\nthe...', as well as allow differing amounts of whitespace (spaces,\\ntabs, newlines, and the like) to lie between the words.",
    "Find doubled words despite capitalization differences, such as with '[The]\\n[the]...', as well as allow differing amounts of whitespace (spaces,",
    'Doubled Words: test 2';
pwc-test './ch-2.raku',
    "to make a word bold: '...it is <B>very</B> very important...'.",
    "to make a word bold: '...it is <B>[very]</B> [very] important...'.",
    'Doubled Words: test 3';
pwc-test './ch-2.raku',
    "Perl officially stands for Practical Extraction and Report Language, except when it doesn't.",
    '',
    'Doubled Words: test 4';
pwc-test './ch-2.raku',
    "There's more than one one way to do it.\\nEasy things should be easy and hard things should be possible.",
    "There's more than [one] [one] way to do it.",
    'Doubled Words: test 5';
