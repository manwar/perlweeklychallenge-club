#!/usr/bin/env raku

use v6.d;

multi sub shift-letter(Str $s where $s ∈ 'a' .. 'z', Int $n --> Str) {
    my @number-to-letter = ('a' .. 'z').List;
    my %letter-to-number = @number-to-letter.antipairs.hash;
    my $new-number = (%letter-to-number{$s} + $n) % @number-to-letter.elems;
    return @number-to-letter[$new-number];
}

multi sub shift-letter(Str $s where $s ∈ 'A' .. 'Z', Int $n --> Str) {
    my @number-to-letter = ('A' .. 'Z').List;
    my %letter-to-number = @number-to-letter.antipairs.hash;
    my $new-number = (%letter-to-number{$s} + $n) % @number-to-letter.elems;
    return @number-to-letter[$new-number];
}

sub jumping-letters(Str $letters where $letters ~~ / ^ <[a..zA..Z]>+ $ /,
                    Int @shifts where $letters.chars == @shifts.elems --> Str) {
    map({ shift-letter($_[0], $_[1]) }, ($letters.comb Z @shifts).List).join;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is jumping-letters('Perl', Array[Int].new((2,22,19,9))), 'Raku', 'works for "Perl"';
    is jumping-letters('Raku', Array[Int].new((24,4,7,17))), 'Perl', 'works for "Raku"';
}
