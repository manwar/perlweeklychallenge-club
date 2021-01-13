#!/usr/bin/env raku

sub challenge(@S) {
    my $output = Set.new;
    for @S -> $word {
        my @permutations = $word.comb.permutations.map(*.join);
        $output ∪= (@S ∩ @permutations).keys.sort.join(',');
    }
    $output.keys.map(*.split(',')).sort
}

multi sub MAIN(*@S where all(@S) ~~ /^<alpha>+$/) {
    say challenge(@S);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (('opt', 'bat', 'saw', 'tab', 'pot', 'top', 'was'), (('bat', 'tab'), ('opt', 'pot', 'top'), ('saw', 'was'))),
        (('x',), (('x',),)),
        (('abc', 'cba', 'ba', 'ab', 'a'), (('a',), ('ab', 'ba'), ('abc', 'cba')))
    );

    for @tests -> (@input, @expected) {
        is(challenge(@input), @expected);
    }

    done-testing;
}
