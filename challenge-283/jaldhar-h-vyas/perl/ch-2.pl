#!/usr/bin/perl
use v5.38;

my @ints = @ARGV;
my $result = 'true';
my %count;

for my $int (@ints) {
    $count{$int}++;
}

for my $n (keys @ints) {
    if (scalar ($count{$n} // 0) != $ints[$n]) {
        $result = 'false';
        last;
    }
}

say $result;
