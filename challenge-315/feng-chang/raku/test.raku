#!/bin/env raku

# The Weekly Challenge 315
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

# Task 1, Find Words
pwc-test './ch-1.raku', <the weekly challenge>, 'e', '0 1 2', 'Find Words: @list=<the weekly challenge> $char="e" => 0,1,2';
pwc-test './ch-1.raku', <perl raku python>,     'p', '0 2',   'Find Words: @list=<perl raku python>     $char="p" => 0,2';
pwc-test './ch-1.raku', <abc def bbb bcd>,      'b', '0 2 3', 'Find Words: @list=<abc def bbb bcd>      $char="b" => 0,2,3';

# Task 2, Find Third
pwc-test './ch-2.raku',
    'Perl is a my favourite language but Python is my favourite too',
    <my favourite>,
    'language too',
    'Find Third: $sentence = "Perl is a my favourite language but Python is my favourite too"
                 $first = "my"
                 $second = "favourite"
              => "language too"';
pwc-test './ch-2.raku',
    'Barbie is a beautiful doll also also a beautiful princess',
    <a beautiful>,
    'doll princess',
    'Find Third: $sentence = "Barbie is a beautiful doll also also a beautiful princess"
                 $first = "a"
                 $second = "beautiful"
              => "doll princess"';
pwc-test './ch-2.raku',
    'we will we will rock you rock you',
    <we will>,
    'we rock',
    'Find Third: $sentence = "we will we will rock you rock you"
                 $first = "we"
                 $second = "will"
              => "we rock"';

pwc-test './ch-2a.raku',
    'Perl is a my favourite language but Python is my favourite too',
    <my favourite>,
    'language too',
    'Find Third: $sentence = "Perl is a my favourite language but Python is my favourite too"
                 $first = "my"
                 $second = "favourite"
              => "language too"';
pwc-test './ch-2a.raku',
    'Barbie is a beautiful doll also also a beautiful princess',
    <a beautiful>,
    'doll princess',
    'Find Third: $sentence = "Barbie is a beautiful doll also also a beautiful princess"
                 $first = "a"
                 $second = "beautiful"
              => "doll princess"';
pwc-test './ch-2a.raku',
    'we will we will rock you rock you',
    <we will>,
    'we rock',
    'Find Third: $sentence = "we will we will rock you rock you"
                 $first = "we"
                 $second = "will"
              => "we rock"';
