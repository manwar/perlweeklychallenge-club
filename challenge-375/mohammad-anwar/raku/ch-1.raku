#!/usr/bin/env raku

use Test;

my @examples = (
    { in => [<apple banana cherry>, <banana cherry date>], out => 2 },
    { in => [<a ab abc>, <a a ab abc>], out => 2 },
    { in => [<orange lemon>, <grape melon>], out => 0 },
    { in => [<test test demo>, <test demo demo>], out => 0 },
    { in => [<Hello world>, <hello world>], out => 1 },
);

for @examples -> %ex {
    is count-unique-common(|%ex<in>), %ex<out>;
}

done-testing;

sub count-unique-common(@array1, @array2) {
    my %freq1;
    my %freq2;

    %freq1{$_}++ for @array1;
    %freq2{$_}++ for @array2;

    return (grep {
        %freq1{$_} == 1 && (%freq2{$_} // 0) == 1
    }, keys %freq1).elems;
}
