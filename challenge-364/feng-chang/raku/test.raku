#!/bin/env raku

# The Weekly Challenge 364
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

# Task 1, Decrypt String
pwc-test './ch-1.raku', '10#11#12',  'jkab',  'Decrypt String: 10#11#12  => jkab';
pwc-test './ch-1.raku', '1326#',     'acz',   'Decrypt String: 1326#     => acz';
pwc-test './ch-1.raku', '25#24#123', 'yxabc', 'Decrypt String: 25#24#123 => yxzbc';
pwc-test './ch-1.raku', '20#5',      'te',    'Decrypt String: 20#5      => te';
pwc-test './ch-1.raku', '1910#26#',  'aijz',  'Decrypt String: 1910#26#  => aijz';

# Task 2, Goal Parser
pwc-test './ch-2.raku', 'G()(al)',        'Goal',    'Goal Parser: "G()(al)"       => Goal';
pwc-test './ch-2.raku', 'G()()()()(al)',  'Gooooal', 'Goal Parser: "G()()()()(al)" => Gooooal';
pwc-test './ch-2.raku', '(al)G(al)()()',  'alGaloo', 'Goal Parser: "(al)G(al)()()" => alGaloo';
pwc-test './ch-2.raku', '()G()G',         'oGoG',    'Goal Parser: "()G()G"        => OGoG';
pwc-test './ch-2.raku', '(al)(al)G()()',  'alalGoo', 'Goal Parser: "(al)(al)G()()" => alalGoo';
