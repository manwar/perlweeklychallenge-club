#!/bin/env raku

# The Weekly Challenge 341
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

# Task 1, Broken Keyboard
pwc-test './ch-1.raku', 'Hello World',          <d>,   1, 'Broken Keyboard: "Hello World",          @keys=<d>   => 1';
pwc-test './ch-1.raku', 'apple banana cherry',  <a e>, 0, 'Broken Keyboard: "apple banana cherry",  @keys=<a e> => 0';
pwc-test './ch-1.raku', 'Coding is fun',               3, 'Broken Keyboard: "Coding is fun",        @keys=<>    => 3';
pwc-test './ch-1.raku', 'The Weekly Challenge', <a b>, 2, 'Broken Keyboard: "The Weekly Challenge", @keys=<a b> => 2';
pwc-test './ch-1.raku', 'Perl and Python',      <p>,   1, 'Broken Keyboard: "Perl and Python",      @keys=<p>   => 1';

# Task 2, Reverse Prefix
pwc-test './ch-2.raku', 'programming', 'g', 'gorpramming', 'Reverse Prefix: programming g => gorpramming';
pwc-test './ch-2.raku', 'hello',       'h', 'hello',       'Reverse Prefix: hello       h => hello';
pwc-test './ch-2.raku', 'abcdefghij',  'h', 'hgfedcbaij',  'Reverse Prefix: abcdefghij  h => hgfedcbaij';
pwc-test './ch-2.raku', 'reverse',     's', 'srevere',     'Reverse Prefix: reverse     s => srevere';
pwc-test './ch-2.raku', 'perl',        'r', 'repl',        'Reverse Prefix: perl        r => repl';
