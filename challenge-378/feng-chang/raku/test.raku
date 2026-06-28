#!/bin/env raku

# The Weekly Challenge 378
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

# Task 1, Second Largest Digit
pwc-test './ch-1.raku', 'aaaaa77777',         -1, 'Second Largest Digit: aaaaa77777         => -1';
pwc-test './ch-1.raku', 'abcde',              -1, 'Second Largest Digit: abcde              => -1';
pwc-test './ch-1.raku', '9zero8eight7seven9', 8,  'Second Largest Digit: 9zero8eight7seven9 => 8';
pwc-test './ch-1.raku', 'xyz9876543210',      8,  'Second Largest Digit: xyz9876543210      => 8';
pwc-test './ch-1.raku', '4abc4def2ghi8jkl2',  4,  'Second Largest Digit: 4abc4def2ghi8jkl2  => 4';

# Task 2, Sum of Words
pwc-test './ch-2.raku', <acb cba cdb>,  'True',  'Sum of Words: <acb cba cdb>  => true';
pwc-test './ch-2.raku', <aab aac ad>,   'True',  'Sum of Words: <aab aac ad>   => true';
pwc-test './ch-2.raku', <bc je jg>,     'False', 'Sum of Words: <bc je jg>     => false';
pwc-test './ch-2.raku', <a aaaa aa>,    'True',  'Sum of Words: <a aaaa aa>    => true';
pwc-test './ch-2.raku', <c d h>,        'False', 'Sum of Words: <c d h>        => false';
pwc-test './ch-2.raku', <gfi hbf bdhd>, 'True',  'Sum of Words: <gfi hbf bdhd> => true';
