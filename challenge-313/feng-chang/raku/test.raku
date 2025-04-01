#!/bin/env raku

# The Weekly Challenge 313
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
pwc-test './ch-1.raku', <perl perrrl>,                  'True',  'Broken Keys: $name="perl",         $typed="perrrl"          => true';
pwc-test './ch-1.raku', <raku rrakuuuu>,                'True',  'Broken Keys: $name="raku",         $typed="rrakuuuu"        => true';
pwc-test './ch-1.raku', <python perl>,                  'False', 'Broken Keys: $name="python",       $typed="perl"            => false';
pwc-test './ch-1.raku', <coffeescript cofffeescccript>, 'True',  'Broken Keys: $name="coffeescript", $typed="cofffeescccript" => true';

# Task 2, Reverse Letters
pwc-test './ch-2.raku', 'p-er?l',           'l-re?p',           'Reverse Letters: p-er?l           => l-re?p';
pwc-test './ch-2.raku', 'wee-k!L-y',        'yLk-e!e-w',        'Reverse Letters: wee-k!L-y        => yLk-e!e-w';
pwc-test './ch-2.raku', '_c-!h_all-en!g_e', '_e-!g_nel-la!h_c', 'Reverse Letters: _c-!h_all-en!g_e => _e-!g_nel-la!h_c';
