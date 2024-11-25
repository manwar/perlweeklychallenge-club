#!/bin/env raku

# The Weekly Challenge 296
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

# Task 1, String Compression
pwc-test './ch-1.raku', 'abbc',    'a2bc',  'String Compression: abbc    => a2bc';
pwc-test './ch-1.raku', 'aaabccc', '3ab3c', 'String Compression: aaabccc => 3ab3c';
pwc-test './ch-1.raku', 'abcc',    'ab2c',  'String Compression: abcc    => ab2c';
pwc-test './ch-1.raku', <-d a2bc>,  'abbc',    'String Decompression: a2bc  => abbc';
pwc-test './ch-1.raku', <-d 3ab3c>, 'aaabccc', 'String Decompression: 3ab3c => aaabccc';
pwc-test './ch-1.raku', <-d ab2c>,  'abcc',    'String Decompression: ab2c  => abcc';

# Task 2, Matchstick Square
pwc-test './ch-2.raku', <1 2 2 2 1>,   'true',  'Matchstick Square: 1,2,2,2,1   => true';
pwc-test './ch-2.raku', <2 2 2 4>,     'false', 'Matchstick Square: 2,2,2,4     => false';
pwc-test './ch-2.raku', <2 2 2 2 4>,   'false', 'Matchstick Square: 2,2,2,2,4   => false';
pwc-test './ch-2.raku', <3 4 1 4 3 1>, 'true',  'Matchstick Square: 3,4,1,4,3,1 => true';
