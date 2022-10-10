#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(recomposemaskcode(["ab-cde-123", "123.abc.420", "3abc-0010.xy"]),
          ["xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy"],
          'example 1');

is-deeply(recomposemaskcode(["1234567.a", "a-1234-bc", "a.b.c.d.e.f"]),
          ["xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f"],
          'example 2');

sub recomposemaskcode(@list) {
    my @out;
    for @list -> $ins {
        my $count = 0;
        my $os = '';
        for $ins.comb -> $c {
            if (($c ge '0' && $c le '9') || ($c ge 'a' && $c le 'z')) {
                if ($count < 4) {
                    $count++;
                    $os ~= 'x';
                } else {
                    $os ~= $c;
                }
            } else {
                $os ~= $c;
            }
        }
        @out.push($os);
    }
    return @out;
}
