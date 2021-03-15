#!/usr/bin/env raku

sub challenge(Str $S) returns Str {
    $S.trim.words.reverse.join(' ');
}

multi sub MAIN(Str $S) {
    say challenge($S);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        ('The Weekly Challenge', 'Challenge Weekly The'),
        ('    Perl and   Raku are  part of the same family  ', 'family same the of part are Raku and Perl')
    );

    for @tests -> ($input, $expected) {
        is(challenge($input), $expected);
    }

    done-testing;
}
