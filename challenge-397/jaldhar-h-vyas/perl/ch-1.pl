#!/usr/bin/perl
use 5.40.1;
use warnings;

sub sum(@arr) {
    my $total;
    for my $n (@arr) {
        $total += $n;
    }

    return $total;
}

my @arr = @ARGV;

my $average = sum(@arr) / scalar @arr;
my $num = int($average) + 1;
if ($num < 1) {
    $num = 1;
}

while (true) {
    unless (grep { $_ == $num } @arr) {
        say $num;
        last;
    }
    $num++;
}
