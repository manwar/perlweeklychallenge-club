#!/bin/env raku

# The Weekly Challenge 275
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

# Task 1, Broken Keys
pwc-test './ch-1.raku', <Perl Weekly Challenge>,    'la', 0, 'Broken Keys: "Perl Weekly Challenge",    <l a> => 0';
pwc-test './ch-1.raku', <Perl and Raku>,            'a',  1, 'Broken Keys: "Perl and Raku",            <a>   => 1';
pwc-test './ch-1.raku', <Well done Team PWC>,       'lo', 2, 'Broken Keys: "Well done Team PWC",       <l o> => 2';
pwc-test './ch-1.raku', <The joys of polyglottism>, 'T',  2, 'Broken Keys: "The joys of polyglottism", <T>   => 2';

# Task 2, Replace Digits
pwc-test './ch-2.raku', 'a1c1e1',   'abcdef',   'Replace Digits: "a1c1e1"   => "abcdef"';
pwc-test './ch-2.raku', 'a1b2c3d4', 'abbdcfdh', 'Replace Digits: "a1b2c3d4" => "abbdcfdh"';
pwc-test './ch-2.raku', 'b2b',      'bdb',      'Replace Digits: "b2b"      => "bdb"';
pwc-test './ch-2.raku', 'a16z',     'abgz',     'Replace Digits: "a16z"     => "abgz"';
