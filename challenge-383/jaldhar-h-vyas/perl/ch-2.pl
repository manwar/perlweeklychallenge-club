#!/usr/bin/perl
use 5.40.1;
use warnings;

sub nearest($n) {
    state @near = (0x0, 0x33, 0x66, 0x99, 0xCC, 0xFF);
    my $result = $near[-1];

    for my $i (1 .. (scalar @near - 1)) {
        if ($n <= $near[$i]) {
            $result = ($n - $near[$i - 1]) < ($near[$i] - $n)
                ? $near[$i - 1]
                : $near[$i];
            last;
        }
    }

    return sprintf('%02X', $result);
}

my ($color) = @ARGV;
my ($r, $g, $b) = map { nearest(hex($_)) } $color =~ /(..)/g;

say "#$r$g$b";
