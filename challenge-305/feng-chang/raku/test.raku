#!/bin/env raku

# The Weekly Challenge 305
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

# Task 1, Binary Prefix
pwc-test './ch-1.raku', <1 0 1>, 'False True True',  'Binary Prefix: (1,0,1) => false,true,true';
pwc-test './ch-1.raku', <1 1 0>, 'False True False', 'Binary Prefix: (1,1,0) => false,true,false';
pwc-test './ch-1.raku',
    <1 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 0 1>,
    'False True True False False True False False False False False False False False False False False False False True',
    'Binary Prefix: (1,1,1,1,0,1,0,0,0,0,1,0,1,0,0,1,0,0,0,1) => false,true,true,false,false,true,false,false,false,false,false,false,false,false,false,false,false,false,false,true';

# Task 2, Alien Dictionary
pwc-test './ch-2.raku', <perl python raku>, 'hlabydefgirkmnopqjstuvwxcz', 'raku python perl',
    'Alien Dictionary: @words=<perl python raku>,     alien="hlabydefgirkmnopqjstuvwxcz" => raku,python,perl';
pwc-test './ch-2.raku', <the weekly challenge>, 'corldabtefghijkmnpqswuvxyz', 'challenge the weekly',
    'Alien Dictionary: @words=<the weekly challenge>, alien="corldabtefghijkmnpqswuvxyz" => challenge,the,weekly';
