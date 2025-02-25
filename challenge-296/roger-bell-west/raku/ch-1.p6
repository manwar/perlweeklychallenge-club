#! /usr/bin/raku

use Test;

plan 6;

is(stringcompression('abbc'), 'a2bc', 'example 1');
is(stringcompression('aaabccc'), '3ab3c', 'example 2');
is(stringcompression('abcc'), 'ab2c', 'example 3');
is(stringdecompression('a2bc'), 'abbc', 'example 4');
is(stringdecompression('3ab3c'), 'aaabccc', 'example 5');
is(stringdecompression('ab2c'), 'abcc', 'example 6');

sub compressedunit($count, $letter) {
    my $out = '';
    if $count > 1 {
        $out ~= $count;
    }
    $out ~= $letter;
    $out;
}

sub stringcompression($a) {
    my $out = '';
    my $lastchar = '';
    my $count = 0;
    for $a.comb -> $c {
        if $count == 0 || $c ne $lastchar {
            if $count > 0 {
                $out ~= compressedunit($count, $lastchar);
            }
            $lastchar = $c;
            $count = 0;
        }
        $count++
    }
    if $count > 0 {
                $out ~= compressedunit($count, $lastchar);
    }
    $out;
}

sub stringdecompression($a) {
    my $out = '';
    my $count = 0;
    for $a.comb -> $c {
        if $c ge '0' && $c le '9' {
            $count *= 10;
            $count += $c;
        } else {
            if $count == 0 {
                $count = 1;
            }
            $out ~=  $c x $count;
            $count = 0;
        }
    }
    $out;
}
