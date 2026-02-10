#!/bin/env raku

# The Weekly Challenge 360
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

# Task 1, Text Justifier
pwc-test './ch-1.raku', 'Hi',    5, '*Hi**',      'Text Justifier: Hi,5    => *Hi**';
pwc-test './ch-1.raku', 'Code', 10, '***Code***', 'Text Justifier: Code,10 => ***Code***';
pwc-test './ch-1.raku', 'Hello', 9, '**Hello**',  'Text Justifier: Hello,9 => **Hello**';
pwc-test './ch-1.raku', 'Perl',  4, 'Perl',       'Text Justifier: Perl,4  => Perl';
pwc-test './ch-1.raku', 'A',     7, '***A***',    'Text Justifier: A,7     => ***A***';
pwc-test './ch-1.raku', '',      5, '*****',      'Text Justifier: "",5    => *****';

# Task 2, Word Sorter
pwc-test './ch-2.raku', 'The quick brown fox',              'brown fox quick The',            'Word Sorter: "The quick brown fox"              => "brown fox quick The"';
pwc-test './ch-2.raku', 'Hello    World!   How   are you?', 'are Hello How World! you?',      'Word Sorter: "Hello    World!   How   are you?" => "are Hello How World! you?"';
pwc-test './ch-2.raku', 'Hello',                            'Hello',                          'Word Sorter: "Hello"                            => "Hello"';
pwc-test './ch-2.raku', 'Hello, World! How are you?',       'are Hello, How World! you?',     'Word Sorter: "Hello, World! How are you?"       => "are Hello, How World! you?"';
pwc-test './ch-2.raku', 'I have 2 apples and 3 bananas!',   '2 3 and apples bananas! have I', 'Word Sorter: "I have 2 apples and 3 bananas!"   => "2 3 and apples bananas! have I"';
