#!/usr/bin/perl
use 5.038;
use warnings;

my %cardinals = (
    1  => 'one',
    2  => 'two',
    3  => 'three',
    4  => 'four',
    5  => 'five',
    6  => 'six',
    7  => 'seven',
    8  => 'eight',
    9  => 'nine',
    10 => 'ten',
    11 => 'eleven',
    12 => 'twelve',
    13 => 'thirteen',
    14 => 'fourteen',
    15 => 'fifteen',
    16 => 'sixteen',
    17 => 'seventeen',
    18 => 'eighteen',
    19 => 'nineteen',
    20 => 'twenty',
    30 => 'thirty',
    40 => 'forty',
    50 => 'fifty',
    60 => 'sixty',
    70 => 'seventy',
    80 => 'eighty',
    90 => 'ninety',
    100 => 'hundred'
);

my %ordinals = (
    1  => 'first',
    2  => 'second',
    3  => 'third',
    4  => 'fourth',
    5  => 'fifth',
    6  => 'sixth',
    7  => 'seventh',
    8  => 'eighth',
    9  => 'ninth',
    10 => 'tenth',
    11 => 'eleventh',
    12 => 'twelfth',
    13 => 'thirteenth',
    14 => 'fourteenth',
    15 => 'fifteenth',
    16 => 'sixteenth',
    17 => 'seventeenth',
    18 => 'eighteenth',
    19 => 'nineteenth',
    20 => 'twentieth',
    30 => 'thirtieth',
    40 => 'fortieth',
    50 => 'fiftieth',
    60 => 'sixtieth',
    70 => 'seventieth',
    80 => 'eightieth',
    90 => 'ninetieth',
    100 => 'hundredth',
    1_000 => 'one thousandth',
);

sub underHundred($cardinals, $ordinals, $n) {
    my ($tens, $units) = split //, $n;

    if ($n < 20) {
        return $ordinals{$n};
    }

    return $units == 0
        ? $ordinals->{$tens * 10}
        : join q{-}, ($cardinals->{$tens * 10}, $ordinals->{$units});
}

sub underThousand ($cardinals, $ordinals, $n) {

    if ($n < 100) {
        return underHundred($cardinals, $ordinals, $n);
    }

    my ($hundreds, $tens, $units) = split //, $n;
    my @parts = ($cardinals->{$hundreds});
    push (@parts, $n % 100
        ? ($cardinals->{100}, 'and',
          underHundred($cardinals, $ordinals, $tens * 10 + $units))
        : $ordinals->{100}
    );

    return join q{ }, @parts;
}

sub makeOrdinal($cardinals, $ordinals, $n) {
    if ($n > 1_000) {
        return "Too big!";
    } elsif ($n == 1_000) {
        return $ordinals->{1_000};
    } else {
        return underThousand($cardinals, $ordinals, $n);
    }
}

my $n = shift // die "Need a positive integer <= 1000.\n";

say makeOrdinal(\%cardinals, \%ordinals, $n);
