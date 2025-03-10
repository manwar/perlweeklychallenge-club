#!/usr/bin/perl
use v5.38;

sub sum {
    my $total;
    for my $n (@_) {
        $total += $n;
    }

    return $total;
}

my ($str, $int) = @ARGV;

my $sum = $str;

while (length $sum > $int) {
    $sum = join q{},  map { sum( split // ) } ($sum =~ /(\d{1,$int})/g);
}

say $sum;
