#!/bin/env raku

# The Weekly Challenge 322
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

# Task 1, String Format
pwc-test './ch-1.raku',       'ABC-D-E-F', 3, 'ABC-DEF', 'String Format: $str="ABC-D-E-F",$i=3 => ABC-DEF';
pwc-test './ch-1.raku',       'A-BC-D-E',  2, 'A-BC-DE', 'String Format: $str="A-BC-D-E", $i=2 => A-BC-DE';
pwc-test './ch-1.raku', '--', '-A-B-CD-E', 4, 'A-BCDE',  'String Format: $str="-A-B-CD-E",$i=4 => A-BCDE';

# Task 2, Rank Array
pwc-test './ch-2.raku', <55 22 44 33>, '4 1 3 2',   'Rank Array: (55,22,44,33) => (4,1,3,2)';
pwc-test './ch-2.raku', <10 10 10>,    '1 1 1',     'Rank Array: (10,10,10)    => (1,1,1)';
pwc-test './ch-2.raku', <5 1 1 4 3>,   '4 1 1 3 2', 'Rank Array: (5,1,1,4,3)   => (4,1,1,3,2)';

pwc-test './ch-2a.raku', <55 22 44 33>, '4 1 3 2',   'Rank Array: (55,22,44,33) => (4,1,3,2)';
pwc-test './ch-2a.raku', <10 10 10>,    '1 1 1',     'Rank Array: (10,10,10)    => (1,1,1)';
pwc-test './ch-2a.raku', <5 1 1 4 3>,   '4 1 1 3 2', 'Rank Array: (5,1,1,4,3)   => (4,1,1,3,2)';
