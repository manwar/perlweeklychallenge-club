#!/usr/bin/env raku
use Test;

is strong-password('a'),         5;
is strong-password('aB2'),       3;
is strong-password('PaaSW0rd'),  0;
is strong-password('Paaasw0rd'), 1;
is strong-password('aaaaa'),     2;

sub strong-password($str)
{
    my $missing;

    $missing++ unless $str ~~ /<digit>/;
    $missing++ unless $str ~~ /<lower>/;
    $missing++ unless $str ~~ /<upper>/;

    my $threes = ($str ~~ m:g/(.) $0 $0/).elems;
    my $steps  = max($threes, $missing); 
    my $chars  = $steps + $str.chars;

    $steps += 6 - $chars if $chars < 6;

    $steps
}
