#!/usr/bin/env perl6

use Test;

is excel-column('Z'),  26, 'Z  => 26';
is excel-column('AB'), 28, 'AB => 28';
is excel-column(28), 'AB', '28 => AB';

done-testing;

multi sub excel-column(Str $name) {

    my $i = 0;
    my $b = 26;
    my $d = 0;

    for $name.uc.flip.comb -> $c {
        $d += ($c.ord - "A".ord + 1) * ($b ** $i++);
    }

    return $d;
}

multi sub excel-column(Int $number is copy) {

    my $name = '';
    my @name = 'A'..'Z';
    @name.unshift(0);

    while $number > 26 {
        my $i = $number div 26;
        $name   ~= @name[$i];
        $number -= $i * 26;
    }
    $name ~= @name[$number];

    return $name;
}
