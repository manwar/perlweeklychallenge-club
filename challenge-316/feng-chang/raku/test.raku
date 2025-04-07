#!/bin/env raku

# The Weekly Challenge 316
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

# Task 1, Circular
pwc-test './ch-1.raku', <perl loves scala>,        'True',  'Circular: <perl loves scala>        => true';
pwc-test './ch-1.raku', <love the programming>,    'False', 'Circular: <love the programming>    => false';
pwc-test './ch-1.raku', <java awk kotlin node.js>, 'True',  'Circular: <java awk kotlin node.js> => true';

# Task 2, Subsequence
pwc-test './ch-2.raku', <uvw bcudvew>,    'True',  'Subsequence: <uvw bcudvew>    => true';
pwc-test './ch-2.raku', <aec abcde>,      'False', 'Subsequence: <aec abcde>      => false';
pwc-test './ch-2.raku', <sip javascript>, 'True',  'Subsequence: <sip javascript> => true';
