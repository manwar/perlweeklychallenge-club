#!/bin/env raku

# The Weekly Challenge 348
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

# Task 1, String Alike
pwc-test './ch-1.raku', 'textbook',     'False', 'String Alike: textbook     => false';
pwc-test './ch-1.raku', 'book',         'True',  'String Alike: book         => true';
pwc-test './ch-1.raku', 'AbCdEfGh',     'True',  'String Alike: AbCdEfGh     => true';
pwc-test './ch-1.raku', 'rhythmmyth',   'True',  'String Alike: rhythmmyth   => true';
pwc-test './ch-1.raku', 'UmpireeAudio', 'False', 'String Alike: UmpireeAudio => false';

# Task 2, Convert Time
pwc-test './ch-2.raku', <02:30 02:45>, 1, 'Convert Time: 02:30 02:45 => 1';
pwc-test './ch-2.raku', <11:55 12:15>, 2, 'Convert Time: 11:55 12:15 => 2';
pwc-test './ch-2.raku', <09:00 13:00>, 4, 'Convert Time: 09:00 13:00 => 4';
pwc-test './ch-2.raku', <23:45 00:30>, 3, 'Convert Time: 23:45 00:30 => 3';
pwc-test './ch-2.raku', <14:20 15:25>, 2, 'Convert Time: 14:20 15:25 => 2';
