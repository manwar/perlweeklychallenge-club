#!/bin/env raku

# The Weekly Challenge 330
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

# Task 1, Clear Digits
pwc-test './ch-1.raku', 'cab12',  'c',    'Clear Digits: cab12  => c';
pwc-test './ch-1.raku', 'xy99',   '',     'Clear Digits: xy99   => ""';
pwc-test './ch-1.raku', 'pa1erl', 'perl', 'Clear Digits: pa1erl => perl';

# Task 2, Title Capital
pwc-test './ch-2.raku', 'PERL IS gREAT',        'Perl is Great',        'Title Capital: PERL IS gREAT        => Perl is Great';
pwc-test './ch-2.raku', 'THE weekly challenge', 'The Weekly Challenge', 'Title Capital: THE weekly challenge => The Weekly Challenge';
pwc-test './ch-2.raku', 'YoU ARE A stAR',       'You Are a Star',       'Title Capital: YoU ARE A stAR       => You Are a Star';
