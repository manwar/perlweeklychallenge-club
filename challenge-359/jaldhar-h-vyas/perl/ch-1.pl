#!/usr/bin/perl
use 5.038;
use warnings;

sub sum(@args) {
    my $total = 0;

    for my $elem (@args) {
        $total += $elem;
    }

    return $total;
}

my ($int) = @ARGV;
my $root = $int;
my $persistence = 0;

while (length $root > 1) {
    $root = sum(split //, $root);
    $persistence++;
}

say "Persistence  = $persistence\nDigital Root = $root";
