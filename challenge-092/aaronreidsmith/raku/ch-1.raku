#!/usr/bin/env raku

use MONKEY-TYPING;

augment class Seq {
    method OrderedSet {
        my @set;
        for self -> $item {
            next if $item ∈ @set;
            @set.push($item);
        }
        @set;
    }
}

sub challenge(Str $A, Str $B) returns Int {
    my $a-chars = $A.comb.OrderedSet.join;
    my $b-chars = $B.comb.OrderedSet.join;
    ($A.trans($a-chars => $b-chars) eq $B).Int;
}

multi sub MAIN(Str $A, Str $B) {
    say challenge($A, $B);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('abc', 'xyz', 1),
        ('abb', 'xyy', 1),
        ('sum', 'add', 0)
    );

    for @tests -> @test {
        is(challenge(@test[0], @test[1]), @test[2]);
    }

    done-testing;
}
