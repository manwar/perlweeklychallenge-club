#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(happy(8),[1, 7, 10, 13, 19, 23, 28, 31],'example 1');

sub ssd($n0) {
    my $n = $n0;
    my $out = 0;
    while ($n > 0) {
        my $d = $n % 10;
        $out += $d * $d;
        $n div= 10;
    }
    return $out;
}

sub happy($ct) {
    my %hm = 1 => True;
    my $c = 0;
    my @out;
    loop {
        $c++;
        unless (%hm{$c}:exists) {
            my $v = $c;
            my $ss = SetHash.new($v);
            my $h = True;
            loop {
                if (%hm{$v}:exists) {
                    $h = %hm{$v};
                    last;
                } else {
                    $v = ssd($v);
                    if ($ss{$v}:exists) {
                        $h = False;
                        last;
                    }
                    $ss{$v}++;
                }
            }
            $ss.keys.map({ %hm{$_} = $h });
        }
        if (%hm{$c}) {
            @out.push($c);
            if (@out.elems >= $ct) {
                last;
            }
        }
    }
    return @out;
}
