#!/bin/env raku

# The Weekly Challenge 366
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

# Task 1, Count Prefixes
pwc-test './ch-1.raku', <a ap app apple banana>,              'apple',   4, 'Count Prefixes: a ap app apple banana,              apple   => 4';
pwc-test './ch-1.raku', <cat dog fish>,                       'bird',    0, 'Count Prefixes: cat dog fish,                       bird    => 0';
pwc-test './ch-1.raku', <hello he hell heaven he>,            'hello',   4, 'Count Prefixes: hello he hell heaven he,            hello   => 4';
pwc-test './ch-1.raku', '', <code coding cod>,                'coding',  3, 'Count Prefixes: "" code coding cod,                 coding  => 3';
pwc-test './ch-1.raku', <p pr pro prog progr progra program>, 'program', 7, 'Count Prefixes: p pr pro prog progr progra program, program => 7';

# Task 2, Valid Times
pwc-test './ch-2.raku', '?2:34',    3, 'Valid Times: ?2:34 =>    3';
pwc-test './ch-2.raku', '?4:?0',   12, 'Valid Times: ?4:?0 =>   12';
pwc-test './ch-2.raku', '??:??', 1440, 'Valid Times: ??:?? => 1440';
pwc-test './ch-2.raku', '?3:45',    3, 'Valid Times: ?3:45 =>    3';
pwc-test './ch-2.raku', '2?:15',    4, 'Valid Times: 2?:15 =>    4';
