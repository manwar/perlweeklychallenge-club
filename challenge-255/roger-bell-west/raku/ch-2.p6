#! /usr/bin/raku

use Test;

plan 2;

is(mostfrequentword('Joe hit a ball, the hit ball flew far after it was hit.', 'hit'), 'ball', 'example 1');
is(mostfrequentword('Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.', 'the'), 'Perl', 'example 2');

sub mostfrequentword($para, $banned) {
    my %words;
    map {%words{$_}++}, $para.comb(/<[A..Za..z]>+/);
    %words{$banned}:delete;
    my $m = %words.values.max;
    my @v = %words.keys.grep({%words{$_} == $m}).sort;
    return @v[0];
}
