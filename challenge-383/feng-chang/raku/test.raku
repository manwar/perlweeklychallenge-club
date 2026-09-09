#!/bin/env raku

# The Weekly Challenge 383
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

# Task 1, Similar List
pwc-test './ch-1.raku', '"great", "acting"', '"fine", "drama"', '["great", "fine"], ["acting", "drama"]', 'True',
    q/Similar List: '"great", "acting"' '"fine", "drama"' '["great", "fine"], ["acting", "drama"]' => true/;
pwc-test './ch-1.raku', '"apple", "pie"', '"banana", "pie"', '["apple", "peach"], ["peach", "banana"]', 'False',
    q/Similar List: '"apple", "pie"', '"banana", "pie"', '["apple", "peach"], ["peach", "banana"]' => false/;
pwc-test './ch-1.raku', '"perl4", "python"', '"raku", "python"', '["perl4", "perl5", "raku"],', 'True',
    q/Similar List: '"perl4", "python"', '"raku", "python"', '["perl4", "perl5", "raku"],'         => true/;
pwc-test './ch-1.raku', '"enjoy", "challenge"', '"love", "weekly", "challenge"', '["enjoy", "love"],', 'False',
    q/Similar List: '"enjoy", "challenge"', '"love", "weekly", "challenge"', '["enjoy", "love"],'  => false/;
pwc-test './ch-1.raku', '"fast", "car"', '"quick", "vehicle"', '["quick", "fast"], ["vehicle", "car"]', 'True',
    q/Similar List: '"fast", "car"', '"quick", "vehicle"', '["quick", "fast"], ["vehicle", "car"]' => true/;

# Task 2, Nearest RGB
pwc-test './ch-2.raku', '#F4B2D1', '#FF99CC', 'Nearest RGB: #F4B2D1 => #FF99CC';
pwc-test './ch-2.raku', '#15E6E5', '#00FFCC', 'Nearest RGB: #15E6E5 => #00FFCC';
pwc-test './ch-2.raku', '#191A65', '#003366', 'Nearest RGB: #191A65 => #003366';
pwc-test './ch-2.raku', '#2D5A1B', '#336633', 'Nearest RGB: #2D5A1B => #336633';
pwc-test './ch-2.raku', '#00FF66', '#00FF66', 'Nearest RGB: #00FF66 => #00FF66';
