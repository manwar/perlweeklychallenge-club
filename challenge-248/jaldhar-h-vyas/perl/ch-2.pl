#!/usr/bin/perl
use 5.030;
use warnings;

my @a = map { [ map { 0 + $_} split /\s+/ ] } @ARGV;
my @b;

for my $row (0 .. scalar @a - 2) {
    my @c;
    for my $col (0 .. scalar @{$a[$row]} - 2) {
        my $sum = $a[$row][$col] + $a[$row][$col + 1] +
            $a[$row + 1][$col] + $a[$row + 1][$col + 1];
        push @c, $sum;
    }
    push @b,\@c;
} 

say "[\n",
    (join ",\n", (map { join q{}, (q{  [ }, (join(q{, }, @{$_})), " ]") } @b)),
    "\n]\n";
