#!/usr/bin/env perl

use JTM::Boilerplate 'script';

my %words = (
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety",
);

MAIN: {
    my %numbers;
    while (my $line = <<>>) {
        chomp $line;
        $line =~ s/[()]//g;
        for my $number (split /[,\s]+/, $line) {
            $numbers{$number} = to_words($number);
        }
    }

    my $str = join ', ', sort { $numbers{$a} cmp $numbers{$b} } keys %numbers;
    say "($str)";
}

sub to_words($number) {
    my $out = "";
    if ($number < 0) {
        $out .= "minus ";
        $number = abs($number);
    }
    if (int($number / 1_000_000_000_000)) {
        my $part = int($number / 1_000_000_000_000);
        $number -= 1_000_000_000_000 * $part;
        $out .= to_words($part) . " trillion";
        if ($number > 0) { $out .= " " }
    }
    if (int($number / 1_000_000_000)) {
        my $part = int($number / 1_000_000_000);
        $number -= 1_000_000_000 * $part;
        $out .= to_words($part) . " billion";
        if ($number > 0) { $out .= " " }
    }
    if (int($number / 1_000_000)) {
        my $part = int($number / 1_000_000);
        $number -= 1_000_000 * $part;
        $out .= to_words($part) . " million";
        if ($number > 0) { $out .= " " }
    }
    if (int($number / 1_000)) {
        my $part = int($number / 1_000);
        $number -= 1_000 * $part;
        $out .= to_words($part) . " thousand";
        if ($number > 0) { $out .= " " }
    }
    if (int($number / 100)) {
        my $part = int($number / 100);
        $number -= 100 * $part;
        $out .= to_words($part) . " hundred";
        if ($number > 0) { $out .= " " }
    }

    if (exists $words{$number}) {
        $out .= $words{$number};
    } else {
        my $part = int($number / 10);
        $number -= 10 * $part;
        $out .= $words{$part*10} . "-" . $words{$number};
    }

    return $out;

}

