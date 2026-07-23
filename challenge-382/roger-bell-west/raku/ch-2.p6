#! /usr/bin/raku

use Test;

plan 5;

is-deeply(replacequestionmark('01??0'), ['01000', '01010', '01100', '01110'], 'example 1');
is-deeply(replacequestionmark('101'), ['101'], 'example 2');
is-deeply(replacequestionmark('???'), ['000', '001', '010', '011', '100', '101', '110', '111'], 'example 3');
is-deeply(replacequestionmark('1?10'), ['1010', '1110'], 'example 4');
is-deeply(replacequestionmark('1?1?0'), ['10100', '10110', '11100', '11110'], 'example 5');

sub replacequestionmark($a) {
    my @template = $a.comb;
    my $q = @template.grep({$_ eq '?'}).elems;
    if ($q == 0) {
        return [$a];
    }
    my @out;
    for 0 .. (1 +< $q) - 1 -> $n {
        my @qm;
        my $nn = $n;
        while ($nn > 0) {
            if ($nn % 2 == 1) {
                @qm.push('1');
            } else {
                @qm.push('0');
                }
            $nn = floor($nn / 2);
        }
        while @qm.elems < $q {
            @qm.push('0');
        }
        my $entry = "";
        for @template -> $tc {
            if ($tc eq '?') {
                $entry ~= @qm.pop;
            } else {
                $entry ~= $tc;
            }
        }
        @out.push($entry);
    }
    @out;
}
