#!/usr/bin/perl
use 5.038;
use warnings;

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my ($str, $k) = @ARGV;

my $base = ord q{`};
my $result = join q{}, map {  ord($_) - $base } split //, $str;
my $i = $k;

while ($i--) {
    $result = sum(split //, $result);
}

say $result;

