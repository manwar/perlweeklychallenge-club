#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated treasure spots, encoded as letter-digit>
# e.g. <script> a2 b1 b2 b3 c4 e6

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::Util qw(max zip);

my @tour;
while(<DATA>) {
    my @row = split /\s+/, $_;
    push @tour, @row;
}
@tour = grep { $_ } @tour;
my @positions = map { chr(int($_/8)+97) . (8 - ($_ % 8)) } (0..63);
@tour = sort { $a->[0] <=> $b->[0] } zip \@tour, \@positions;

my @treasure = (scalar @ARGV) ? (map {lc $_} @ARGV) : qw(a2 b1 b2 b3 c4 e6);
my $maxIx = max map {my $treasureSpot = $_; my @a = grep {$_->[1] eq $treasureSpot} @tour; $a[0]->[0]} @treasure;
for (@tour[0..$maxIx-1]) {
    my $pos = $_;
    say $pos->[0] . " -- " . $pos->[1] . ((scalar grep {$_ eq $pos->[1]} @treasure) ? (" TREASURE") : (""));
};

__DATA__
 1  50  45  62  31  18   9  64
46  61  32  49  10  63  30  17
51   2  47  44  33  28  19   8
60  35  42  27  48  11  16  29
41  52   3  34  43  24   7  20
36  59  38  55  26  21  12  15
53  40  57   4  23  14  25   6
58  37  54  39  56   5  22  13
