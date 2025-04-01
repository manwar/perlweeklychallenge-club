#! /usr/bin/raku

use Test;

plan 3;

is-deeply(findthird('Perl is a my favourite language but Python is my favourite too.', 'my', 'favourite'), ['language', 'too'], 'example 1');
is-deeply(findthird('Barbie is a beautiful doll also also a beautiful princess.', 'a', 'beautiful'), ['doll', 'princess'], 'example 2');
is-deeply(findthird('we will we will rock you rock you.', 'we', 'will'), ['we', 'rock'], 'example 3');

sub findthird($s, $a, $b) {
    my @ss;
    my $sa = "";
    for $s.comb -> $c {
        if ( $c ~~ /<alpha>/) {
            $sa ~= $c;
        } else {
            if ($sa.chars > 0) {
                @ss.push($sa);
                $sa = "";
            }
        }
    }
    if ($sa.chars > 0) {
        @ss.push($sa);
    }
    my @out;
    for @ss.rotor(3 => -2) -> @p {
        if (@p[0] eq $a && @p[1] eq $b) {
            @out.push(@p[2]);
        }
    }
    @out;
}
