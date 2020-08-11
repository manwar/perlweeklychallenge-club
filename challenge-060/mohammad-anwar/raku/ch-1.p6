#!/usr/bin/env perl6

use v6.d;

multi sub MAIN(*@) is hidden-from-USAGE {
    say $*USAGE;
}

multi sub MAIN(Str :$name?, Int :$number?) {
    die "ERROR: Missing --name=<Str> or --number=<Int>.\n"
        unless defined $name or defined $number;

    defined $name
    ??
    say sprintf("%s => %s", $name, excel-column($name))
    !!
    say sprintf("%s => %s", $number, excel-column($number.Int));
}

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
