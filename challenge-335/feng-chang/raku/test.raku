#!/bin/env raku

# The Weekly Challenge 335
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

# Task 1, Common Characters
pwc-test './ch-1.raku', <bella label roller>, 'e l l', 'Common Characters: ("bella","label","roller") => ("e", "l", "l")';
pwc-test './ch-1.raku', <cool lock cook>,     'c o',   'Common Characters: ("cool","lock","cook")     => ("c", "o")';
pwc-test './ch-1.raku', <hello world pole>,   'l o',   'Common Characters: ("hello","world","pole")   => ("l", "o")';
pwc-test './ch-1.raku', <abc def ghi>,        '',      'Common Characters: ("abc","def","ghi")        => ()';
pwc-test './ch-1.raku', <aab aac aaa>,        'a a',   'Common Characters: ("aab","aac","aaa")        => ("a", "a")';

# Task 2, Find Winner
pwc-test './ch-2.raku', '[0,0],[1,0],[1,1],[1,2],[2,2]',                         'A',
    'Find Winner: [0,0],[1,0],[1,1],[1,2],[2,2]                         => A';
pwc-test './ch-2.raku', '[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]',                   'B',
    'Find Winner: [0,0],[1,1],[0,1],[0,2],[1,0],[2,0]                   => B';
pwc-test './ch-2.raku', '[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]', 'Draw',
    'Find Winner: [0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2] => Draw';
pwc-test './ch-2.raku', '[0,0],[1,1]',                                           'Pending',
    'Find Winner: [0,0],[1,1]                                           => Pending';
pwc-test './ch-2.raku', '[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]',                   'B',
    'Find Winner: [1,1],[0,0],[2,2],[0,1],[1,0],[0,2]                   => B';
