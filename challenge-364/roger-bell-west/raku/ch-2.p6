#! /usr/bin/raku

use Test;

plan 5;

is(goalparser('G()(al)'), 'Goal', 'example 1');
is(goalparser('G()()()()(al)'), 'Gooooal', 'example 2');
is(goalparser('(al)G(al)()()'), 'alGaloo', 'example 3');
is(goalparser('()G()G'), 'oGoG', 'example 4');
is(goalparser('(al)(al)G()()'), 'alalGoo', 'example 5');

sub goalparser($a) {
    my $out = "";
    my $s = 0;
    while ($s < $a.chars) {
        if ($a.substr($s).starts-with("G")) {
            $s += 1;
            $out ~= "G";
        } elsif ($a.substr($s).starts-with("()")) {
            $s += 2;
            $out ~= "o";
        } elsif ($a.substr($s).starts-with("(al)")) {
            $s += 4;
            $out ~= "al";
        } else {
            return "";
        }
    }
    $out;
}
