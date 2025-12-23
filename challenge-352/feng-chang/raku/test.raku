#!/bin/env raku

# The Weekly Challenge 352
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

# Task 1, Match String
pwc-test './ch-1.raku', <cat cats dog dogcat dogcat rat ratcatdogcat>, 'cat dog dogcat rat',     'Match String: <cat cats dog dogcat dogcat rat ratcatdogcat> => <cat dog dogcat rat>';
pwc-test './ch-1.raku', <hello hell world wor ellow elloworld>,        'hell world wor ellow',   'Match String: <hello hell world wor ellow elloworld>        => <hell world wor ellow>';
pwc-test './ch-1.raku', <a aa aaa aaaa>,                               'a aa aaa',               'Match String: <a aa aaa aaaa>                               => <a aa aaa>';
pwc-test './ch-1.raku', <flower flow flight fl fli ig ght>,            'flow fl fli ig ght',     'Match String: <flower flow flight fl fli ig ght>            => <flow fl fli ig ght>';
pwc-test './ch-1.raku', <car carpet carpenter pet enter pen pent>,     'car pet enter pen pent', 'Match String: <car carpet carpenter pet enter pen pent>     => <car pet enter pen pent>';

# Task 2, Binary Prefix
pwc-test './ch-2.raku', <0 1 1 0 0 1 0 1 1 1>, 'true, false, false, false, false, true, true, false, false, false',  'Binary Prefix: <0 1 1 0 0 1 0 1 1 1> => true, false, false, false, false, true, true, false, false, false';
pwc-test './ch-2.raku', <1 0 1 0 1 0>,         'false, false, true, true, false, false',                             'Binary Prefix: <1 0 1 0 1 0>         => false, false, true, true, false, false';
pwc-test './ch-2.raku', <0 0 1 0 1>,           'true, true, false, false, true',                                     'Binary Prefix: <0 0 1 0 1>           => true, true, false, false, true';
pwc-test './ch-2.raku', <1 1 1 1 1>,           'false, false, false, true, false',                                   'Binary Prefix: <1 1 1 1 1>           => false, false, false, true, false';
pwc-test './ch-2.raku', <1 0 1 1 0 1 0 0 1 1>, 'false, false, true, false, false, true, true, true, false, false',   'Binary Prefix: <1 0 1 1 0 1 0 0 1 1> => false, false, true, false, false, true, true, true, false, false';
