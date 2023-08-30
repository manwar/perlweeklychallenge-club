#!/bin/env raku

# The Weekly Challenge 227
use Test;

sub pwc-test(Str:D $script, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    is $p.out.slurp(:close).chomp, $expect, $assertion;
}

# Task 1, Friday 13th
pwc-test './ch-1.raku', 2023, 2, 'Friday 13th: 2023 => 2';

# Task 2, Roman Maths
pwc-test './ch-2.raku', 'IV + V',     'IX',         'Roman Maths: IV + V     => IX';
pwc-test './ch-2.raku', 'M - I',      'CMXCIX',     'Roman Maths: M - I      => CMXCIX';
pwc-test './ch-2.raku', 'X / II',     'V',          'Roman Maths: X / II     => V';
pwc-test './ch-2.raku', 'XI * VI',    'LXVI',       'Roman Maths: XI * VI    => LXVI';
pwc-test './ch-2.raku', 'VII ** III', 'CCCXLIII',   'Roman Maths: VII ** III => CCCXLIII';
pwc-test './ch-2.raku', 'V - V',      'nulla',      'Roman Maths: V - V      => nulla';
pwc-test './ch-2.raku', 'V / II',     'non potest', 'Roman Maths: V / II     => non potest';
pwc-test './ch-2.raku', 'MMM + M',    'non potest', 'Roman Maths: MMM + M    => non potest';
pwc-test './ch-2.raku', 'V - X',      'non potest', 'Roman Maths: V - X      => non potest';

done-testing;
