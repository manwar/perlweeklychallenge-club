#!/bin/env raku

# The Weekly Challenge 311
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

# Task 1, Upper Lower
pwc-test './ch-1.raku', 'pERl',   'PerL',   'Upper Lower: pERl   => PerL';
pwc-test './ch-1.raku', 'rakU',   'RAKu',   'Upper Lower: rakU   => RAKu';
pwc-test './ch-1.raku', 'PyThOn', 'pYtHoN', 'Upper Lower: PyThOn => pYtHoN';

# Task 2, Group Digit Sum
pwc-test './ch-2.raku', 111122333,    3, 359, 'Group Digit Sum: $str="111122333",    $int=3 => 359';
pwc-test './ch-2.raku', 1222312,      2, 76,  'Group Digit Sum: $str="1222312",      $int=2 =>  76';
pwc-test './ch-2.raku', 100012121001, 4, 162, 'Group Digit Sum: $str="100012121001", $int=4 => 162';
