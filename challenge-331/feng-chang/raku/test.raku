#!/bin/env raku

# The Weekly Challenge 331
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

# Task 1, Last Word
pwc-test './ch-1.raku', 'The Weekly Challenge', 9, 'Last Word: "The Weekly Challenge" => 9';
pwc-test './ch-1.raku', '   Hello   World    ', 5, 'Last Word: "   Hello   World    " => 5';
pwc-test './ch-1.raku', "Let's begin the fun",  3, 'Last Word: "Let\'s begin the fun"  => 3';

# Task 2, Buddy Strings
pwc-test './ch-2.raku', <fuck fcuk>, 'True',  'Buddy Strings: fuck fcuk => true';
pwc-test './ch-2.raku', <love love>, 'False', 'Buddy Strings: love love => false';
pwc-test './ch-2.raku', <fodo food>, 'True',  'Buddy Strings: fodo food => true';
pwc-test './ch-2.raku', <feed feed>, 'True',  'Buddy Strings: feed feed => true';
