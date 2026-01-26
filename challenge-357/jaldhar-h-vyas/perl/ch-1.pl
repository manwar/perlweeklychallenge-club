#!/usr/bin/perl
use 5.038;
use warnings;
use constant KAPREKAR => 6174;

my ($int) = @ARGV;
my $count = 0;

while ($int != KAPREKAR) {
    if ($int == 0) {
        $count = -1;
        last;
    }

    my $smaller = sprintf("%04d", join q{}, sort split //, $int);
    my $larger = reverse $smaller;
    $int = $larger - $smaller;
    $count++;
}

say $count;
