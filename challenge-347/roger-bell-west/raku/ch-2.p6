#! /usr/bin/raku

use Test;

plan 5;

is(formatphonenumber('1-23-45-6'), '123-456', 'example 1');
is(formatphonenumber('1234'), '12-34', 'example 2');
is(formatphonenumber('12 345-6789'), '123-456-789', 'example 3');
is(formatphonenumber('123 4567'), '123-45-67', 'example 4');
is(formatphonenumber('123 456-78'), '123-456-78', 'example 5');

sub formatphonenumber($a) {
    (my $p = $a) ~~ s:g/\D+//;
    my @pure = $p.comb;
    my $left = @pure.elems;
    my @out = [];
    my $i = 0;
    if ($left > 4) {
        for @pure -> $c {
            @out.push($c);
            $i++;
            $left--;
            if ($i % 3 == 0) {
                @out.push('-');
                if ($left <= 4) {
                    last;
                }
            }
        }
    }
    if ($left == 4) {
        @out.push(@pure[$i]);
        @out.push(@pure[$i + 1]);
        @out.push('-');
        $i += 2;
    }
    for $i .. @pure.end -> $p {
        @out.push(@pure[$p]);
    }
    @out.join('');
}
