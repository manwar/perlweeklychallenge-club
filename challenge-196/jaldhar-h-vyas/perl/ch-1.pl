#!/usr/bin/perl
use 5.030;
use warnings;

my @list = @ARGV // die "need a list of integers separated by spaces";

for my $i (0 .. scalar @list - 3) {
    for my $j ($i + 1 .. scalar @list - 2) {
        for my $k ($j + 1 .. scalar @list - 1) {
            if ($list[$i] < $list[$k] && $list[$k] < $list[$j]) {
                say q{(}, (join q{, }, ($list[$i], $list[$j], $list[$k])), q{)};
                exit;
            }
        }
    }
}

say q{()};
