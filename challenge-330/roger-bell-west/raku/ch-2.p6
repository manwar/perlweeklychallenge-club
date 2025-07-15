#! /usr/bin/raku

use Test;

plan 3;

is(titlecapital('PERL IS gREAT'), 'Perl is Great', 'example 1');
is(titlecapital('THE weekly challenge'), 'The Weekly Challenge', 'example 2');
is(titlecapital('YoU ARE A stAR'), 'You Are a Star', 'example 3');

sub titlecapital($a) {
    my @out;
    for $a.split(' ') -> $w {
        my $p = lc($w);
        if ($p.chars > 2) {
            $p = tclc($p);
        }
        @out.push($p);
    }
    join(' ', @out);
}
