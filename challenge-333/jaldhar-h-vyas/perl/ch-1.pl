#!/usr/bin/perl
use 5.038;
use warnings;

my @list = @ARGV;

if (scalar @list < 3) {
    say "Need atleast 3 points";
    exit;
}

my @coords = map { [split /,/] } @list;

my ($x0, $y0) = @{$coords[0]};
my ($x1, $y1) = @{$coords[1]};
my $dx = $x1 - $x0;
my $dy = $y1 - $y0;

for my $coord (@coords[2 .. $#coords]) {
    my ($x, $y) = @{$coord};

    if ($dx * ($y - $y0) != $dy * ($x - $x0)) {
        say "False";
        exit;
    }
}
say "True";

