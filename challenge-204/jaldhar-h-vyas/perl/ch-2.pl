#!/usr/bin/perl
use 5.030;
use warnings;

my $r = shift;
my $c = shift;

my @input = map { int $_; } map { split /\s+/, $_; } @ARGV;

if ($r * $c > scalar @input) {
    say 0;
    exit;
}

my @output;

for my $i (0 .. $r - 1) {
    my @temp;
    for my $j (0 .. $c - 1) {
        push @temp, shift @input;
    }

    push @output, \@temp;
}

if (scalar @output > 1) {
    print '[ ';
}

print join q{, }, map { '[ ' . (join q{, }, @{$_}) . ' ]' } @output;


if (scalar @output > 1) {
    print ' ]';
}

print "\n";
