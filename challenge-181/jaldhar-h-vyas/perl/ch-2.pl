#!/usr/bin/perl
use 5.030;
use warnings;
use English;

open my $fh, '<', 'temperature.txt' or die "$OS_ERROR\n";
local $RS = undef; 
my $data = <$fh>;
close $fh;

my @lines = split /\n/, $data;
my %temperatures;

for my $line (@lines) {
    chomp $line;
    my ($date, $temperature) = split q{, }, $line;
    $temperatures{$date} = $temperature;
}

my $previousTemp = 'Inf';

for my $k (sort { $a cmp $b } keys %temperatures) {
    if ($temperatures{$k} > $previousTemp) {
        say $k;
    }
    $previousTemp = $temperatures{$k};
}