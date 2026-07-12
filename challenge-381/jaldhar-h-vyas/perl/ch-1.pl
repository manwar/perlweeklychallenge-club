#!/usr/bin/perl
use 5.40.1;
use warnings;

my @matrix = map { [ split /\s+/ ] } @ARGV;
my $n = scalar @matrix;
my $ints = join q{}, 1 .. $n;
my $isSame = true;

for my $side (0 .. $n - 1) {

    my $row = join q{}, sort{ $a <=> $b } @{$matrix[$side]};
    my $col = join q{}, sort { $a <=> $b } map { $_->[$side] } @matrix;

    if ($row ne $ints || $col ne $ints) {
        $isSame = false;
        last;
    }
}

say $isSame ? 'true' : 'false';